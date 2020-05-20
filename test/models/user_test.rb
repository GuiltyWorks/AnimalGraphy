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
