# == Schema Information
#
# Table name: post_tag_relations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_post_tag_relations_on_post_id  (post_id)
#  index_post_tag_relations_on_tag_id   (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (tag_id => tags.id)
#
FactoryBot.define do
  factory :post_tag_relation do
    sequence(:post_id) { |n| n }
    sequence(:tag_id) { |n| n }
    association :post
    association :tag
  end
end
