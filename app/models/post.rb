class Post < ApplicationRecord
  validates :comment, { presence: true, length: { maximum: 1000 } }
  validates :user_id, { presence: true }
  validates :image_name, { presence: true }

  mount_uploader :image_name, ImageUploader

  belongs_to :user
  has_one :tag
end
