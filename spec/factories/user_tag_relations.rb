# == Schema Information
#
# Table name: user_tag_relations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_id     :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_tag_relations_on_tag_id   (tag_id)
#  index_user_tag_relations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (tag_id => tags.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_tag_relation do
    sequence(:user_id) { |n| n }
    sequence(:tag_id) { |n| n }
    association :user
    association :tag
  end
end
