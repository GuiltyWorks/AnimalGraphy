class UsersController < ApplicationController
  before_action :authenticate_user!, { only: [ :edit, :update, :delete, :destroy ] }
  before_action :set_target_user, { only: [ :show, :edit, :update, :delete, :destroy, :likes ] }
  before_action :forbid_login_user, { only: [ :new, :create, :login_form, :login ] }
  before_action :ensure_correct_user, { only: [ :edit, :update, :delete, :destroy ] }

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
  end

  def update
    @user.name = params[:name]
    @user.email = params[:email]
    @user.image_name = params[:image] if params[:image]

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def delete
  end

  def destroy
    @user.destroy
    @posts = Post.where(user_id: params[:id])
    @posts.each(&:destroy)
    @tags = Post.where(user_id: params[:id])
    @tags.each(&:destroy)
    @likes = Like.where(user_id: params[:id])
    @likes.each(&:like)
    @replies = Reply.where(user_id: params[:id])
    @replies.each(&:destroy)
    flash[:notice] = "アカウントを削除しました"
    redirect_to("/posts/index")
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def likes
  end

  private

  def set_target_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
