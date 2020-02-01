class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
  end

  def destroy
  end
end
