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
end
