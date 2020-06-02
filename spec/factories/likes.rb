FactoryBot.define do
  factory :like do
    sequence(:user_id) { |n| n }
    sequence(:post_id) { |n| n }
  end
end
