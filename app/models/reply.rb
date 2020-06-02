class Reply < ApplicationRecord
  validates :user_id, { presence: true }
  validates :post_id, { presence: true }
  validates :comment, { presence: true, length: { maximum: 1000 } }

  def user
    return User.find_by(id: user_id)
  end

  def post
    return Post.find_by(id: post_id)
  end
end
