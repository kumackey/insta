# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_post_id              (post_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Like, type: :model do
  it "有効なファクトリを持つこと" do
    like = build(:like)
    expect(like).to be_valid
  end

  it "ユーザの無いいいねは無効なこと" do
    like = build(:like, user_id: nil)
    expect(like).not_to be_valid
  end

  it "投稿の無いいいねは無効なこと" do
    like = build(:like, post_id: nil)
    expect(like).not_to be_valid
  end

  it "likeメソッドが有効なこと" do
    user = create(:user)
    post = create(:post)
    like_by_user = user.like(post)
    expect(like_by_user.include?(post)).to be_truthy
  end
end
