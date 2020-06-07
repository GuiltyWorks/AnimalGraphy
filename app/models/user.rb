class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]

  validates :name, { presence: true }
  validates :email, { presence: true, uniqueness: true }

  mount_uploader :image_name, ImageUploader

  has_many :posts

  def self.create_guest
    find_or_create_by!(email: "guest@guestmail.com") do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Date.today
    end
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end
end
