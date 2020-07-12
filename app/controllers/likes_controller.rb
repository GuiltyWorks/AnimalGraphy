class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Like.find_by(user_id: current_user.id, post_id: params[:id])
      flash[:notice] = "いいね済みです。"
      return
    end
    like = Like.new(user_id: current_user.id, post_id: params[:id])
    like.save
    @liked = true
    @post_id = params[:id]
    @likes_count = Like.where(post_id: params[:id]).count
    render "posts/like.js.erb"
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    like&.destroy
    @liked = false
    @post_id = params[:id]
    @likes_count = Like.where(post_id: params[:id]).count
    render "posts/like.js.erb"
  end
end
