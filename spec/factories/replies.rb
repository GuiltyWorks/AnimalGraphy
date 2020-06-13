FactoryBot.define do
  factory :reply do
    sequence(:user_id) { |n| n }
    sequence(:post_id) { |n| n }
    sequence(:comment) { |n| "Test Comment #{n}" }
    association :user
    association :post
  end
end
