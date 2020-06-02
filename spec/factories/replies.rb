FactoryBot.define do
  factory :reply do
    sequence(:user_id) { |n| n }
    sequence(:post_id) { |n| n }
    comment { "comment" }
  end
end
