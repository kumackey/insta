require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  it "有効なファクトリを持つこと" do
    expect(user).to be_valid
  end
  
  it "名前が空白であるときに無効なこと" do
    user.name = '     '
    user.valid?
    expect(user.errors.messages[:name]).to include("を入力してください")
  end

  describe "名前の最大文字数が100文字" do
    context "名前が100文字" do
      let(:user) { FactoryBot.build(:user, name:'a' * 100) }
      it "有効であること" do
        expect(user).to be_valid
      end
    end
    context "名前が101文字" do
      let(:user) { FactoryBot.build(:user, name:'a' * 101) }
      it "無効であること" do
        user.valid?
        expect(user.errors[:name]).to include("は100文字以内で入力してください")
      end
    end
  end

  it "Eメールが空白であるときに無効なこと" do
    user.email = '     '
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email:"dup@example.com")
    user = FactoryBot.build(:user, email:"dup@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "ユーザが消去されたとき投稿も消えること" do
  owner = FactoryBot.create(:user)
  FactoryBot.create(:post, user_id: owner.id)
  expect{ owner.destroy }.to change{ Post.count }.by(-1)
  end
end
