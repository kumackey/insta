require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'ポスト投稿' do
    it '投稿できること' do
      @user = FactoryBot.create(:user)
      visit login_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: '1234512345'
      click_button 'ログイン'
      visit new_post_path
      attach_file '画像', Rails.root.join('spec', 'factories', 'test1.png')
      fill_in '本文', with: 'This is an example post'
      click_button '登録する'
      expect(page).to have_content '投稿しました'
    end
  end
end
