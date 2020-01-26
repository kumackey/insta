class CommentsController < ApplicationController
  before_action :require_login, only: %i[create]

  def create
    @comment = current_user.comments.build(comment_create_params)
    @comment.save
  end

  private

  def comment_create_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end
end
