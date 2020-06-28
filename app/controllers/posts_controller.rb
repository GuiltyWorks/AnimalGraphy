class PostsController < ApplicationController
  before_action :authenticate_user!, { only: [ :new, :create, :edit, :update, :destroy ] }
  before_action :set_target_post, { only: [ :show, :edit, :update, :destroy ] }
  before_action :ensure_correct_user, { only: [ :edit, :update, :destroy ] }

  def index
    @posts = Post.all.includes(:user, :tags).order(created_at: :desc).page(params[:page])
    @active_list = make_active_list(nil)
  end

  def search
    if params[:keyword].blank?
      redirect_to posts_path
      return
    end

    keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
    negative_keywords, positive_keywords = keywords.partition { |keyword| keyword.start_with?("-") }
    @posts = Post.none
    positive_keywords.each do |keyword|
      @posts = @posts.or(Post.where("comment LIKE ?", "%#{keyword}%"))
    end
    negative_keywords.each do |keyword|
      @posts.where!("comment NOT LIKE ?", "%#{keyword.delete_prefix('-')}%")
    end

    @posts = @posts.includes(:user, :tags).order(created_at: :desc).page(params[:page])
    @active_list = make_active_list(nil)
    render "posts/index"
  end

  def ranking
    case params[:period]
    when "all"
      ranking = Like.group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
    when "monthly"
      period = Date.today.in_time_zone.all_month
      ranking = Like.where(created_at: period).group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
    when "weekly"
      period = Date.today.in_time_zone.all_week
      ranking = Like.where(created_at: period).group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
    when "daily"
      period = Date.today.in_time_zone.all_day
      ranking = Like.where(created_at: period).group(:post_id).order("count(post_id) desc").limit(10).pluck(:post_id)
    else
      flash[:notice] = "ランキングが見つかりませんでした。"
      redirect_to posts_path
      return
    end

    @posts = Kaminari.paginate_array(Post.includes(:user, :tags).find(ranking)).page(params[:page])
    @active_list = make_active_list(params[:period])
    render "posts/index"
  end

  def tags
    tag = Tag.find_by(id: params[:id])
    if tag.nil?
      flash[:notice] = "タグが見つかりませんでした。"
      redirect_to posts_path
      return
    end

    @posts = tag.posts.includes(:user, :tags).order(created_at: :desc).page(params[:page])
    @active_list = make_active_list(Tag.find(params[:id]).name)
    render "posts/index"
  end

  def show
    @reply = Reply.new(post_id: @post.id)
    @reply.attributes = flash[:reply] if flash[:reply]
    @replies = Reply.where(post_id: params[:id]).order(created_at: :desc)
  end

  def new
    @post = Post.new(flash[:post])
  end

  def create
    @post = Post.new(post_params)
    @post.tag_ids = detection(params[:post][:image].read) if params[:post][:image]

    if @post.save
      flash[:notice] = "投稿を作成しました。"
      redirect_to posts_path
    else
      redirect_back fallback_location: new_post_path, flash: {
        post: @post,
        error_messages: @post.errors.full_messages,
      }
    end
  end

  def edit
    @post.attributes = flash[:post] if flash[:post]
  end

  def update
    unless params[:post][:image]
      @post.comment = params[:post][:comment]

      if @post.save
        flash[:notice] = "投稿を編集しました。"
        redirect_to @post
      else
        redirect_back fallback_location: edit_post_path, flash: {
          post: @post,
          error_messages: @post.errors.full_messages,
        }
      end

      return
    end

    @post.tag_ids = detection(params[:post][:image].read)
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました。"
      redirect_to @post
    else
      redirect_back fallback_location: edit_post_path, flash: {
        post: @post,
        error_messages: @post.errors.full_messages,
      }
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  private

  def set_target_post
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:notice] = "投稿が見つかりませんでした。"
      redirect_to posts_path
      return
    end
  end

  def ensure_correct_user
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません。"
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:image, :comment).merge(user_id: current_user.id)
  end

  def make_active_list(key)
    active_list = {
      "all" => "inactive",
      "monthly" => "inactive",
      "weekly" => "inactive",
      "daily" => "inactive",
    }
    Tag.all.each do |tag|
      active_list[tag.name] = "inactive"
    end
    active_list[key] = "active"

    return active_list
  end

  def detection(binary_image)
    model = OnnxRuntime::Model.new("public/object_detection/yolov3.onnx")
    labels = File.readlines("public/object_detection/coco-labels-2014_2017.txt").map(&:chomp)

    img = MiniMagick::Image.read(binary_image)
    image_size = [ [ img.height, img.width ] ]
    img.combine_options do |b|
      b.resize "416x416"
      b.gravity "center"
      b.background "transparent"
      b.extent "416x416"
    end
    img_data = Numo::SFloat.cast(img.get_pixels)
    img_data /= 255.0
    image_data = img_data.transpose(2, 0, 1).expand_dims(0).to_a
    output = model.predict(input_1: image_data, image_shape: image_size) # 物体検出
    boxes, scores, indices = output.values
    results = indices.map { |idx| { class: idx[1], score: scores[idx[0]][idx[1]][idx[2]], box: boxes[idx[0]][idx[2]] } }

    tag_ids = []
    results.each do |r|
      label = labels[r[:class]]
      score = r[:score]
      # 判定結果が動物かつ確率が50%以上の場合のみ検出扱い
      if label != "other" && score > 0.5
        tag = Tag.find_by(name: label)
        tag_ids.push(tag&.id)
      end
    end

    return tag_ids.compact
  end
end
