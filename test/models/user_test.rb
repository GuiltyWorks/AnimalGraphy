# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  description            :text(65535)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  image                  :string(255)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  name                   :string(255)
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  uid                    :string(255)
#  unconfirmed_email      :string(255)
#  unlock_token           :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user_1 = User.new(name: nil, email: nil, image_name: nil, password: nil)
    @user_2 = User.new(name: nil, email: nil, image_name: nil, password: "password")
    @user_3= User.new(name: nil, email: nil, image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: nil)
    @user_4 = User.new(name: nil, email: nil, image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: "password")
    @user_5 = User.new(name: nil, email: "test@testmail.com", image_name: nil, password: nil)
    @user_6 = User.new(name: nil, email: "test@testmail.com", image_name: nil, password: "password")
    @user_7 = User.new(name: nil, email: nil, image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: nil)
    @user_8 = User.new(name: nil, email: "test@testmail.com", image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: "password")
    @user_9 = User.new(name: "test", email: nil, image_name: nil, password: nil)
    @user_10 = User.new(name: "test", email: nil, image_name: nil, password: "password")
    @user_11 = User.new(name: "test", email: nil, image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: nil)
    @user_12 = User.new(name: "test", email: nil, image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: "password")
    @user_13 = User.new(name: "test", email: "test@testmail.com", image_name: nil, password: nil)
    @user_14 = User.new(name: "test", email: "test@testmail.com", image_name: nil, password: "password")
    @user_15 = User.new(name: "test", email: "test@testmail.com", image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: nil)
    @user_16 = User.new(name: "test", email: "test@testmail.com", image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')), password: "password")
  end

  test "create user" do
    assert_not @user_1.valid?
    assert_not @user_2.valid?
    assert_not @user_3.valid?
    assert_not @user_4.valid?
    assert_not @user_5.valid?
    assert_not @user_6.valid?
    assert_not @user_7.valid?
    assert_not @user_8.valid?
    assert_not @user_9.valid?
    assert_not @user_10.valid?
    assert_not @user_11.valid?
    assert_not @user_12.valid?
    assert_not @user_13.valid?
    assert @user_14.valid?
    assert_not @user_15.valid?
    assert @user_16.valid?
  end
end
