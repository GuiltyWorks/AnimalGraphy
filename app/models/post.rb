class Post < ApplicationRecord
  validates :comment, { presence: true, length: { maximum: 1000 } }
  validates :user_id, { presence: true }

  def user
    return User.find_by(id: self.user_id)
  end
end
