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
class Reply < ApplicationRecord
  validates :user_id, { presence: true }
  validates :post_id, { presence: true }
  validates :comment, { presence: true, length: { maximum: 1000 } }

  belongs_to :user
  belongs_to :post
end
