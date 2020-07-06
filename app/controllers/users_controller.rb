class UsersController < ApplicationController
  before_action :set_target_user, { only: [ :show, :likes ] }

  def index
    @users = User.all.order(created_at: :desc).page(params[:page])
  end

  def show
    @posts = @user.posts.includes(:tags).order(created_at: :desc).page(params[:page])
  end

  def likes
    @posts = Kaminari.paginate_array(@user.likes.includes(post: [ :user, :tags ]).order(created_at: :desc).map(&:post)).page(params[:page])
  end

  private

  def set_target_user
    @user = User.find(params[:id])
  end
end
