require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  it '投稿を編集できること' do
    user = login_user_as(user)
    post = FactoryBot.create(:post, user: user, content: 'This is first post')

    #編集に失敗
    visit edit_post_path post
    attach_file '画像', Rails.root.join('spec', 'factories', 'test2.png')
    fill_in '本文', with: ''
    click_button '更新する'
    expect(page).to have_content '更新に失敗しました'
    visit posts_path
    expect(page).to have_content 'This is first post'

    #編集に成功
    visit edit_post_path post
    attach_file '画像', Rails.root.join('spec', 'factories', 'test2.png')
    fill_in '本文', with: 'This is second post'
    click_button '更新する'
    expect(page).to have_content '投稿を更新しました'
    visit post_path post
    expect(page).to have_content 'This is second post'
    expect(page).not_to have_content 'This is first post'
  end
end
