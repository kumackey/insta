# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  avatar           :string(255)
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

FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    avatar { File.open("#{Rails.root}/spec/factories/test1.png") }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password  { "1234512345" }
    password_confirmation { "1234512345" }
  end
end
