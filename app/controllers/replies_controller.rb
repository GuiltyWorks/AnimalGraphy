class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target_reply, { only: [ :edit, :update, :destroy ] }
  before_action :ensure_correct_user, { only: [ :edit, :update, :destroy ] }

  def create
    @reply = Reply.create(reply_params)
    @reply.save
    redirect_to @reply.post
  end

  def edit
  end

  def update
    if @reply.update(reply_params)
      flash[:notice] = "リプライを編集しました"
      redirect_to @reply.post
    else
      render("replies/edit")
    end
  end

  def destroy
    post_id = @reply.post_id
    @reply.destroy
    redirect_to("/posts/#{post_id}")
  end

  private

  def set_target_reply
    @reply = Reply.find(params[:id])
  end

  def ensure_correct_user
    if @reply.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def reply_params
    params.require(:reply).permit(:post_id, :comment).merge(user_id: current_user.id)
  end
end
