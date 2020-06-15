class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, { only: [ :edit, :update, :destroy ] }

  def create
    @reply = Reply.new(user_id: current_user.id, post_id: params[:post_id], comment: params[:comment])
    @reply.save
    redirect_to("/posts/#{params[:post_id]}")
  end

  def edit
    @reply = Reply.find_by(id: params[:id])
  end

  def update
    @reply = Reply.find_by(id: params[:id])
    @reply.comment = params[:comment]

    if @reply.save
      flash[:notice] = "リプライを編集しました"
      redirect_to("/posts/#{@reply.post_id}")
    else
      render("replies/edit")
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    post_id = @reply.post_id
    @reply.destroy
    redirect_to("/posts/#{post_id}")
  end

  def ensure_correct_user
    @reply = Reply.find(params[:id])
    if @reply.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
