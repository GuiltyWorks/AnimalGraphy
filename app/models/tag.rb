# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  validates :name, { presence: true }

  has_many :post_tag_relations, dependent: :delete_all
  has_many :posts, through: :post_tag_relations
  has_many :user_tag_relations, dependent: :delete_all
  has_many :users, through: :user_tag_relations
end
