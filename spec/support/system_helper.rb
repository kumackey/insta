module SystemHelper
  def login_user
    user = create(:user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '1234512345'
    click_button 'ログイン'
  end

  def login_user_as(user)
    user = create(:user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '1234512345'
    click_button 'ログイン'
    user
  end

  def wait_for_ajax(wait_time = Capybara.default_max_wait_time)
    Timeout.timeout(wait_time) do
      loop until finished_all_ajax_requests?
    end
    yield if block_given?
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end
