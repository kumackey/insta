require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  it '投稿に失敗したときに投稿画面に遷移すること' do
    login_user
    visit new_post_path
    fill_in '本文', with: ''
    click_button '登録する'
    expect(page).to have_content '投稿に失敗しました'
    expect(page).to have_content '本文を入力してください'
  end
end
