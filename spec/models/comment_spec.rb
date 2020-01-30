# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "有効なファクトリを持つこと" do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it "ユーザの無いコメントは無効なこと" do
    comment = build(:comment, user_id: nil)
    expect(comment).not_to be_valid
  end

  it "投稿の無いコメントは無効なこと" do
    comment = build(:comment, post_id: nil)
    expect(comment).not_to be_valid
  end

  it "テキストの無いコメントは無効なこと" do
    comment = build(:comment, content: nil)
    expect(comment).not_to be_valid
  end

  describe "コメントのテキストの文字数が最大140文字" do
    context "コメントのテキストが140文字のときに" do
      let(:comment) { create(:comment, content: 'a'*140) }
      it "有効なこと" do
        expect(comment).to be_valid
      end
    end
    context "コメントのテキストが141文字のときに" do
      it "無効なこと" do
        comment = build(:comment, content: 'a'*141)
        expect(comment).not_to be_valid
      end
    end
  end
end
