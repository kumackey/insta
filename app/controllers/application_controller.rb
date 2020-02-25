class ApplicationController < ActionController::Base
  before_action :set_search_posts_form
  add_flash_types :success, :info, :warning, :danger

  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end

  protected

  def not_authenticated
    redirect_to login_path, success: 'ログインしてください'
  end

  private

  def search_post_params
    params.fetch(:q, {}).permit(:content)
  end
end
