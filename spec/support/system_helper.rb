module SystemHelper
  def login_user
    user = FactoryBot.create(:user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '1234512345'
    click_button 'ログイン'
  end
end
