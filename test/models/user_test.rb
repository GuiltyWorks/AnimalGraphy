require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user_1 = User.new(name: nil, email: nil, image_name: nil, password: nil)
    @user_2 = User.new(name: "test", email: nil, image_name: nil, password: nil)
    @user_3 = User.new(name: nil, email: "test@testmail.com", image_name: nil, password: nil)
    @user_4 = User.new(name: nil, email: nil, image_name: "default.jpg", password: nil)
    @user_5 = User.new(name: nil, email: nil, image_name: nil, password: "password")
    @user_6 = User.new(name: "test", email: "test@testmail.com", image_name: "default.jpg", password: "password")
  end

  test "create user" do
    assert_not @user_1.valid?
    assert_not @user_2.valid?
    assert_not @user_3.valid?
    assert_not @user_4.valid?
    assert_not @user_5.valid?
    assert @user_6.valid?
  end
end
