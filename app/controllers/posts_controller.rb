class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @users = User.limit(5)
    @posts = if logged_in?
               current_user.feed.includes(:user)
             else
               Post.all.includes(:user)
             end
    @posts = @posts.page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_back_or_to posts_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_back_or_to posts_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました'
  end

  def search
    @posts = Post.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
