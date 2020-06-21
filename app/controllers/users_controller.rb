class UsersController < ApplicationController
  before_action :authenticate_user!, { only: [ :update ] }
  before_action :set_target_user, { only: [ :show, :likes ] }

  def index
    @users = User.all
  end

  def show
  end

  def likes
  end

  private

  def set_target_user
    @user = User.find(params[:id])
  end
end
