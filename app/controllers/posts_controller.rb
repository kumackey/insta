class PostsController < ApplicationController
  # skip_before_action :require_login, only: %i[index]

  def index
    @posts = Post.all.includes(:user)
  end

  def show
    @posts = Post.all.includes(:user)
  end
end
