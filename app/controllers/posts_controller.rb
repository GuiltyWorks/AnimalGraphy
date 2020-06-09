require "mini_magick"
require "numo/narray"
require "onnxruntime"

class PostsController < ApplicationController
  before_action :authenticate_user!, { only: [:new, :create, :edit, :update, :destroy] }
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def index
    @posts = Post.all.order(created_at: :desc)
    @active_list = make_active_list(nil)
  end

  def search
    if params[:keyword] == ""
      redirect_to "/posts/index"
    else
      keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
      negative_keywords, positive_keywords = keywords.partition { |keyword| keyword.start_with?("-") }
      @posts = Post.none
      positive_keywords.each do |keyword|
        @posts = @posts.or(Post.where("comment LIKE ?", "%#{keyword}%"))
      end
      negative_keywords.each do |keyword|
        @posts.where!("comment NOT LIKE ?", "%#{keyword.delete_prefix("-")}%")
      end

      @active_list = make_active_list(nil)
      render("posts/index")
    end
  end

  def ranking
    periods = ["all", "monthly", "weekly", "daily"]
    if !periods.include?(params[:period])
      flash[:notice] = "ランキングが見つかりませんでした"
      redirect_to("/posts/index")
    else
      if params[:period] == "monthly"
        period = Date.today.in_time_zone.all_month
        ranking = Like.where(created_at: period).group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
      elsif params[:period] == "weekly"
        period = Date.today.in_time_zone.all_week
        ranking = Like.where(created_at: period).group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
      elsif params[:period] == "daily"
        period = Date.today.in_time_zone.all_day
        ranking = Like.where(created_at: period).group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
      elsif params[:period] == "all"
        ranking = Like.group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
      end

      @posts = Post.find(ranking)
      @active_list = make_active_list(params[:period].to_sym)
      render("posts/index")
    end
  end

  def tags
    tag = params[:tag]
    tags = ["bird", "cat", "dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe"]
    if !tags.include?(tag)
      flash[:notice] = "タグが見つかりませんでした"
      redirect_to("/posts/index")
    else
      @posts = Post.where(id: Tag.where(tag.to_sym => true).pluck(:post_id)).order(created_at: :desc)
      @active_list = make_active_list(tag.to_sym)
      render("posts/index")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @reply = Reply.new
    @replies = Reply.where(post_id: params[:id]).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      comment: params[:comment],
      user_id: current_user.id,
      image_name: params[:image],
    )

    if @post.save
      detection_result = detection("public#{@post.image_name}")

      @tag = Tag.new(post_id: @post.id)
      detection_result.each do |tag|
        @tag[tag.to_sym] = true
      end

      @tag.save

      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.comment = params[:comment]
    @post.image_name = params[:image] if params[:image]

    if @post.save
      if params[:image]
        detection_result = detection("public#{@post.image_name}")

        @tag = Tag.find_by(post_id: @post.id)
        detection_result.each do |tag|
          @tag[tag.to_sym] = true
        end

        @tag.save
      end

      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/#{@post.id}")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    @tag = Tag.find_by(post_id: params[:id])
    @tag.destroy
    @replies = Reply.where(post_id: params[:id])
    @replies.each do |reply|
      reply.destroy
    end

    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def make_active_list(key)
    active_list = {
      all: "inactive",
      monthly: "inactive",
      weekly: "inactive",
      daily: "inactive",
      general: "inactive",
      bird: "inactive",
      cat: "inactive",
      dog: "inactive",
      horse: "inactive",
      sheep: "inactive",
      cow: "inactive",
      elephant: "inactive",
      bear: "inactive",
      zebra: "inactive",
      giraffe: "inactive",
    }
    if key
      active_list[key] = "active"
    end

    return active_list
  end

  def detection(img_name)
    model = OnnxRuntime::Model.new("public/object_detection/yolov3.onnx")
    labels = File.readlines("public/object_detection/coco-labels-2014_2017.txt")

    img = MiniMagick::Image.open(img_name)
    image_size = [[img.height, img.width]]
    img.combine_options do |b|
      b.resize "416x416"
      b.gravity "center"
      b.background "transparent"
      b.extent "416x416"
    end
    img_data = Numo::SFloat.cast(img.get_pixels)
    img_data /= 255.0
    image_data = img_data.transpose(2, 0, 1).expand_dims(0).to_a

    # 物体検出
    output = model.predict(input_1: image_data, image_shape: image_size)

    boxes, scores, indices = output.values
    results = indices.map do |idx|
      { class: idx[1], score: scores[idx[0]][idx[1]][idx[2]], box: boxes[idx[0]][idx[2]] }
    end

    animals = ["bird", "cat", "dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe"]
    result = []

    results.each do |r|
      label = labels[r[:class]].chomp
      score = r[:score]

      # 判定結果が動物かつ確率が50%以上の場合のみ検出扱い
      result.push(label) if animals.include?(label) && score > 0.5
    end

    return result
  end
end
