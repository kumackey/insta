class ApplicationController < ActionController::Base
  before_action :set_search_posts_form
  add_flash_types :success, :info, :warning, :danger

  def set_search_posts_form
    @search_form = SearchPostsForm.new
  end

  protected

  def not_authenticated
    redirect_to login_path, success: 'ログインしてください'
  end
end
