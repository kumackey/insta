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
end
