require "mini_magick"
require "numo/narray"
require "onnxruntime"

class PostsController < ApplicationController
  before_action :authenticate_user, { only: [:new, :create, :edit, :update, :destroy] }
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def index
    @posts = Post.all.order(created_at: :desc)
    @tags = Tag.all.order(created_at: :desc)
  end

  def tags
    tag = params[:tag]
    tags = ["bird", "cat", "dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe"]
    if tags.include?(tag)
      @tags = Tag.where(tag.to_sym => true).order(created_at: :desc)
    else
      flash[:notice] = "タグが見つかりませんでした"
      redirect_to("/posts/index")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @tag = Tag.find_by(post_id: @post.id)
    @user = @post.user
    @likes_count = Like.where(post_id: params[:id]).count
    @reply = Reply.new
    @replies = Reply.where(post_id: params[:id]).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      comment: params[:comment],
      user_id: @current_user.id,
    )

    if params[:image] && @post.save
      image = params[:image]
      File.binwrite("public/post_images/#{@post.id}.jpg", image.read)

      detection_result = detection("public/post_images/#{@post.id}.jpg")

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

    if @post.save
      if params[:image]
        image = params[:image]
        File.binwrite("public/post_images/#{@post.id}.jpg", image.read)

        detection_result = detection("public/post_images/#{@post.id}.jpg")

        @tag = Tag.find_by(post_id: @post.id)
        detection_result.each do |tag|
          @tag[tag.to_sym] = true
        end

        @tag.save
      end

      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
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
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
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
      if animals.include?(label) && score > 0.5
        puts label
        result.push(label)
      end
    end

    return result
  end
end
