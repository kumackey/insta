require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }
  it "有効なファクトリを持つこと" do
    expect(post).to be_valid
  end
end
