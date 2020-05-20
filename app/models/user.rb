require "bcrypt"

class User < ApplicationRecord
  has_secure_password

  validates :name, { presence: true }
  validates :email, { presence: true, uniqueness: true }

  mount_uploader :image_name, ImageUploader

  has_many :posts

  def self.digest(pwd)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(pwd, cost: cost)
  end
end
