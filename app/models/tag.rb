class Tag < ApplicationRecord
  validates :post_id, { presence: true }
end
