require "bcrypt"

class User < ApplicationRecord
  has_secure_password

  validates :name, { presence: true }
  validates :email, { presence: true, uniqueness: true }
  validates :image_name, { presence: true }

  def posts
    return Post.where(user_id: self.id).order(created_at: :desc)
  end

  def self.digest(pwd)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(pwd, cost: cost)
  end
end
