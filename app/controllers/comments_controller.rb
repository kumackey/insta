class CommentsController < ApplicationController
  before_action :require_login, only: %i[create]

  def create
    @comment = current_user.comments.build(comment_create_params)
    if @comment.save
      redirect_back_or_to posts_path, success: 'コメントしました'
    else
      flash.now[:danger] = 'コメントに失敗しました'
      render :new
    end
  end

  private

  def comment_create_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end
end
