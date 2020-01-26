require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  it 'コメントしたときにコメントが表示されること' do
    user = login_user_as(user)
    post = FactoryBot.create(:post, user: user, content: 'This is first post')
    visit post_path post
    fill_in 'コメント', with: 'This is an example comment'
    click_button '投稿'
    expect(page).to have_content 'This is an example comment'
  end
end
