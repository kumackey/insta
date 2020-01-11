require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }
  it "有効なファクトリを持つこと" do
    expect(post).to be_valid
  end

  it "ユーザの無い投稿は無効なこと" do
    post = FactoryBot.build(:post, user_id: nil)
    expect(post).not_to be_valid
  end

  it "テキストの無い投稿は無効なこと" do
    post = FactoryBot.build(:post, content: nil)
    expect(post).not_to be_valid
  end
  describe "投稿のテキストの文字数が最大140文字" do
    context "投稿のテキストが140文字のときに" do
      let(:post) { FactoryBot.create(:post, content: 'a'*140) }
      it "有効なこと" do
        expect(post).to be_valid
      end
    end
    context "投稿のテキストが141文字のときに" do
      it "無効なこと" do
        post = FactoryBot.build(:post, content: 'a'*141)
        expect(post).not_to be_valid
      end
    end
  end
end
