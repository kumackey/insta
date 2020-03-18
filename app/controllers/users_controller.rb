class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10).order(created_at: :desc)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_back_or_to login_path, success: 'ユーザを作成しました'
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
