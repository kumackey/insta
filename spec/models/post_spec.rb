# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  images     :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  it "有効なファクトリを持つこと" do
    post = build(:post)
    expect(post).to be_valid
  end

  it "ユーザの無い投稿は無効なこと" do
    post = build(:post, user_id: nil)
    expect(post).not_to be_valid
  end

  it "テキストの無い投稿は無効なこと" do
    post = build(:post, content: nil)
    expect(post).not_to be_valid
  end
  describe "投稿のテキストの文字数が最大140文字" do
    context "投稿のテキストが140文字のときに" do
      let(:post) { create(:post, content: 'a'*140) }
      it "有効なこと" do
        expect(post).to be_valid
      end
    end
    context "投稿のテキストが141文字のときに" do
      it "無効なこと" do
        post = build(:post, content: 'a'*141)
        expect(post).not_to be_valid
      end
    end
  end

  it "投稿が消去されたときコメントも消えること" do
    post = create(:post)
    create(:comment, post_id: post.id)
    expect{ post.destroy }.to change{ Comment.count }.by(-1)
  end

  it "投稿が消去されたときいいねも消えること" do
    post = create(:post)
    create(:like, post_id: post.id)
    expect{ post.destroy }.to change{ Like.count }.by(-1)
  end
end
