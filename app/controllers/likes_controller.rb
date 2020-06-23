class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Like.find_by(user_id: current_user.id, post_id: params[:id])
      flash[:notice] = "いいね済みです。"
      redirect_to "/posts/#{params[:id]}"
      return
    end

    like = Like.new(user_id: current_user.id, post_id: params[:id])
    like.save
    redirect_to like.post
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    like.destroy
    redirect_to like.post
  end
end
