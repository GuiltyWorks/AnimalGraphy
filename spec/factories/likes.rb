# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
FactoryBot.define do
  factory :like do
    sequence(:user_id) { |n| n }
    sequence(:post_id) { |n| n }
    association :user
    association :post
  end
end
