class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target_reply, { only: [ :edit, :update, :destroy ] }
  before_action :ensure_correct_user, { only: [ :edit, :update, :destroy ] }

  def create
    @reply = Reply.new(reply_params)
    if @reply.save
      @saved = true
      @replies = Reply.where(post_id: params[:reply][:post_id]).includes(:user).page(params[:page])
    else
      @saved = false
      @error_messages = @reply.errors.full_messages
      # redirect_back fallback_location: @reply.post, flash: {
      #  reply: @reply,
      #  error_messages: @reply.errors.full_messages,
      # }
    end
  end

  def edit
    @reply.attributes = flash[:reply] if flash[:reply]
  end

  def update
    if @reply.update(reply_params)
      redirect_to @reply.post, notice: "リプライを編集しました。"
    else
      redirect_back fallback_location: edit_reply_path(@reply), flash: {
        notice: "リプライの編集に失敗しました。",
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
    @reply = Reply.find_by(id: params[:id])
    if @reply.nil?
      redirect_to posts_path, notice: "リプライが見つかりませんでした。"
      return
    end
  end

  def ensure_correct_user
    redirect_to posts_path, notice: "権限がありません。" if @reply.user_id != current_user.id
  end

  def reply_params
    params.require(:reply).permit(:post_id, :comment).merge(user_id: current_user.id)
  end
end
