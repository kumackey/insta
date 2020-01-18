require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  it "ユーザを作成でき、そのユーザでログインできること" do
    visit new_user_path
    fill_in '名前', with: @user.name
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: '1234512345'
    fill_in 'パスワード確認', with: '1234512345'
    click_on '登録'
    expect(page).to have_content 'ユーザを作成しました'
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: '1234512345'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end
end