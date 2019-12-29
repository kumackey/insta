class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show]
  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_path unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, success: 'ユーザを作成しました'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
