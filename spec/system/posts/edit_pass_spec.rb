require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  it '投稿できること' do
    user = login_user_as(user)
    post = FactoryBot.create(:post, user: user, content: 'This is first post')
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
