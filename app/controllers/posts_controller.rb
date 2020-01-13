class PostsController < ApplicationController
  skip_before_action :require_login

  def index
    @posts = Post.all.includes(:user)
  end

  def create
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def show
    @posts = Post.all.includes(:user)
  end
end
