# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Post < ApplicationRecord
  validates :comment, { presence: true, length: { maximum: 1000 } }
  validates :user_id, { presence: true }
  validates :image, { presence: true }

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :post_tag_relations, dependent: :delete_all
  has_many :tags, through: :post_tag_relations
  has_many :likes, dependent: :delete_all
  has_many :replies, dependent: :delete_all
end
