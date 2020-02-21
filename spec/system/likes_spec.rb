require 'rails_helper'

RSpec.xdescribe 'Likes', type: :system do
  it 'いいねボタンを押すといいねが出来、もう一度押すといいねが外れること' do
    user = login_user_as(user)
    other_user = create(:user)
    post = create(:post, user: other_user, content: 'This is a favorite post')

    visit posts_path
    expect(page.find_by_id("like_area-#{post.id}")).not_to have_css('.far-heart')
    expect(page.find_by_id("like_area-#{post.id}")).to have_css('.fa-heart')
    
    expect {
      within find("#like_area-#{post.id}") do
        find('.fa-heart').click
        wait_for_ajax(1)
      end
    }.to change{ Like.count }.by(1)

    expect {
      within find("#like_area-#{post.id}") do
        find('.fa-heart').click
        wait_for_ajax(1)
      end
    }.to change{ Like.count }.by(-1)

    expect(page.find_by_id("like_area-#{post.id}")).not_to have_css('.far-heart')
    expect(page.find_by_id("like_area-#{post.id}")).to have_css('.fa-heart')
  end
end