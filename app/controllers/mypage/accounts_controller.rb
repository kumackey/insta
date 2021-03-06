class Mypage::AccountsController < Mypage::BaseController
  def edit; end

  def update
    if current_user.update(account_params)
      redirect_to edit_mypage_account_path, success: 'プロフィールを更新しました'
    else
      flash.now['danger'] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  private

  def account_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache)
  end
end
