FactoryBot.define do
  factory :post do
    sequence(:image) { |n| "image/#{n}" }
    content { "テストです" }
    association :user
  end
end