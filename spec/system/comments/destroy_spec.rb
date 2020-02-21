require 'rails_helper'

RSpec.xdescribe 'Comments', type: :system do
  it '自分のコメントは削除でき、他人のコメントは削除できないこと' do
    user = login_user_as(user)
    other_user = create(:user)
    post = create(:post)
    comment_by_other_user = create(:comment,
      post: post,
      user: other_user,
      content: 'This is a comment by other user.'
    )
    comment_by_user = create(:comment,
      post: post,
      user: user,
      content: 'This is a comment by user.'
    )
    visit post_path post
    expect(page.find_by_id("comment-#{comment_by_other_user.id}")).not_to have_css('.fa-trash-alt')
    expect(page.find_by_id("comment-#{comment_by_user.id}")).to have_css('.fa-trash-alt')
    
    expect(page).to have_content('This is a comment by user.')
    find('.fa-trash-alt').click
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content('This is a comment by user.')
  end
end
