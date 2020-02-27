require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  xit '投稿に失敗したときに投稿画面に遷移すること' do
    login_user

    #投稿に失敗時
    visit new_post_path
    fill_in '本文', with: ''
    click_button '登録する'
    expect(page).to have_content '投稿に失敗しました'
    expect(page).to have_content '本文を入力してください'

    #投稿に成功時
    visit new_post_path
    attach_file '画像', Rails.root.join('spec', 'factories', 'test1.png')
    fill_in '本文', with: 'This is an example post'
    click_button '登録する'
    expect(page).to have_content '投稿しました'
    expect(page).to have_content 'This is an example post'
  end
end
