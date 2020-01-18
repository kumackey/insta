require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  it 'ログアウトしているときに投稿編集画面に遷移しないこと' do
    login_user
    click_link 'ログアウト'
    visit new_post_path
    expect(page).to have_content 'ログインしてください'
  end
end