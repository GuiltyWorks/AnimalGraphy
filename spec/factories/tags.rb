FactoryBot.define do
  factory :tag do
    sequence(:post_id) { |n| n }
    association :post
  end
end
