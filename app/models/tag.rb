class Tag < ApplicationRecord
  validates :post_id, { presence: true }

  belongs_to :post
end
