class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  protected

  def not_authenticated
    redirect_to login_path, success: 'ログインしてください'
  end
end
