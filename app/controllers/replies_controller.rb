class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target_reply, { only: [ :edit, :update, :destroy ] }
  before_action :ensure_correct_user, { only: [ :edit, :update, :destroy ] }

  def create
    @reply = Reply.create(reply_params)
    if @reply.save
      redirect_to @reply.post
    else
      redirect_back fallback_location: @reply.post, flash: {
        reply: @reply,
        error_messages: @reply.errors.full_messages,
      }
    end
  end

  def edit
    @reply.attributes = flash[:reply] if flash[:reply]
  end

  def update
    if @reply.update(reply_params)
      flash[:notice] = "リプライを編集しました。"
      redirect_to @reply.post
    else
      redirect_back fallback_location: edit_reply_path(@reply), flash: {
        reply: @reply,
        error_messages: @reply.errors.full_messages,
      }
    end
  end

  def destroy
    @reply.destroy
    redirect_to @reply.post
  end

  private

  def set_target_reply
    @reply = Reply.find(params[:id])
  end

  def ensure_correct_user
    if @reply.user_id != current_user.id
      flash[:notice] = "権限がありません。"
      redirect_to posts_path
    end
  end

  def reply_params
    params.require(:reply).permit(:post_id, :comment).merge(user_id: current_user.id)
  end
end
