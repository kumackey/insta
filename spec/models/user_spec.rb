# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  name             :string(255)      not null
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
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
      let(:user) { build(:user, name:'a' * 100) }
      it "有効であること" do
        expect(user).to be_valid
      end
    end
    context "名前が101文字" do
      let(:user) { build(:user, name:'a' * 101) }
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
    create(:user, email:"dup@example.com")
    user = build(:user, email:"dup@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "ユーザが消去されたとき投稿も消えること" do
    owner = create(:user)
    create(:post, user_id: owner.id)
    expect{ owner.destroy }.to change{ Post.count }.by(-1)
  end

  it "ユーザが消去されたとき投稿のコメントも消えること" do
    owner = create(:user)
    post_by_owner = create(:post, user_id: owner.id)
    create(:comment, post_id: post_by_owner.id)
    expect{ owner.destroy }.to change{ Comment.count }.by(-1)
  end

  it "ユーザが消去されたとき投稿のいいねも消えること" do
    owner = create(:user)
    post_by_owner = create(:post, user_id: owner.id)
    create(:like, post_id: post_by_owner.id)
    expect{ owner.destroy }.to change{ Like.count }.by(-1)
  end

  it "like、unlikeメソッドが有効なこと" do
    user = create(:user)
    post = create(:post)
    expect { user.like(post) }.to change{ Like.count }.by(1)
    expect(user.like?(post)).to be_truthy
    expect { user.unlike(post) }.to change{ Like.count }.by(-1)
    expect(user.like?(post)).not_to be_truthy
  end

  describe "relationship" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    it "フォローしている状態が有効なこと" do
      relationship = user.active_relationships.build(followed_id: other_user.id)
      expect(relationship).to be_valid
    end

    it "フォローとアンフォローが可能なこと" do
      expect(user.following?(other_user)).not_to be_truthy
      expect(other_user.followers.include?(user)).not_to be_truthy
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      expect(other_user.followers.include?(user)).to be_truthy
      user.unfollow(other_user)
      expect(user.following?(other_user)).not_to be_truthy
      expect(other_user.followers.include?(user)).not_to be_truthy
    end
    
    it "フィードが機能していること" do
      post_by_user = create(:post, user_id: user.id)
      post_by_other_user = create(:post, user_id: other_user.id)
      expect(user.feed.include?(post_by_other_user)).not_to be_truthy
      expect(user.feed.include?(post_by_user)).to be_truthy
      user.follow(other_user)
      expect(user.feed.include?(post_by_other_user)).to be_truthy
      user.unfollow(other_user)
      expect(user.feed.include?(post_by_other_user)).not_to be_truthy
    end
  end

end
