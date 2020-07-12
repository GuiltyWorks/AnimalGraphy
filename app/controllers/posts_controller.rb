class PostsController < ApplicationController
  before_action :authenticate_user!, { only: [ :new, :create, :edit, :update, :destroy ] }
  before_action :create_new_post, { only: [ :index, :search, :ranking, :tags ] }
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
      redirect_to posts_path, notice: "ランキングが見つかりませんでした。"
      return
    end

    @posts = Kaminari.paginate_array(Post.includes(:user, :tags).find(ranking)).page(params[:page])
    @active_list = make_active_list(params[:period])
  end

  def tags
    tag = Tag.find_by(id: params[:id])
    if tag.nil?
      redirect_to posts_path, notice: "タグが見つかりませんでした。"
      return
    end

    @posts = tag.posts.includes(:user, :tags).order(created_at: :desc).page(params[:page])
    @active_list = make_active_list(Tag.find(params[:id]).name)
  end

  def show
    @reply = Reply.new(post_id: @post.id)
    @reply.attributes = flash[:reply] if flash[:reply]
  end

  def new
    @post = Post.new(flash[:post])
  end

  def create
    @post = Post.new(post_params)
    @posts = Post.none.page(params[:page])
    if @post.save
      @saved = true
      if params[:post][:from_path] == posts_path
        @from_posts_path = true
        @posts = Post.all.includes(:user, :tags).order(created_at: :desc).page(params[:page])
      elsif params[:post][:from_path] == new_post_path || params[:post][:from_path].nil?
        redirect_to posts_path, notice: "投稿を作成しました。"
      else
        @from_posts_path = false
      end
      ObjectDetectionWorker.perform_async(@post.id)
    else
      @saved = false
      @from_posts_path = false
      @error_messages = @post.errors.full_messages
    end
  end

  def edit
    @post.attributes = flash[:post] if flash[:post]
  end

  def update
    if params[:post][:image]
      if @post.update(post_params)
        redirect_to @post, notice: "投稿を編集しました。"
        ObjectDetectionWorker.perform_async(@post.id)
      else
        redirect_back fallback_location: edit_post_path, flash: {
          post: @post,
          error_messages: @post.errors.full_messages,
        }
      end
    else
      @post.comment = params[:post][:comment]
      if @post.save
        redirect_to @post, notice: "投稿を編集しました。"
      else
        redirect_back fallback_location: edit_post_path, flash: {
          post: @post,
          error_messages: @post.errors.full_messages,
        }
      end
      return
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def create_new_post
    @post = Post.new(flash[:post])
  end

  def set_target_post
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      redirect_to posts_path, notice: "投稿が見つかりませんでした。"
      return
    end
  end

  def ensure_correct_user
    redirect_to posts_path, notice: "権限がありません。" if @post.user_id != current_user.id
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
    active_list[key] = "active" unless key.nil?

    return active_list
  end
end
