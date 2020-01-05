require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  it "有効なファクトリを持つこと" do
    expect(user).to be_valid
  end
end
