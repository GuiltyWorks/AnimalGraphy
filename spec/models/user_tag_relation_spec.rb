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
require 'rails_helper'

RSpec.describe UserTagRelation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
