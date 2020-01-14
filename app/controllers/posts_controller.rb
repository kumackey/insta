class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def index
    @posts = Post.all.includes(:user)
  end

  def create
    @post = current_user.posts.build(post_params)
  end

  def new
    @post = Post.new
  end

  def show
    @posts = Post.all.includes(:user)
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
