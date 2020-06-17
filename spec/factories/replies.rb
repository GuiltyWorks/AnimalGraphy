# == Schema Information
#
# Table name: replies
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
FactoryBot.define do
  factory :reply do
    sequence(:user_id) { |n| n }
    sequence(:post_id) { |n| n }
    sequence(:comment) { |n| "Test Comment #{n}" }
    association :user
    association :post
  end
end
