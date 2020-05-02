require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template "users/login_form"
    post login_path, params: { email: "invalid@invalidmail.com", password: "invalid" }
    assert_not is_logged_in?
  end

  test "login with valid information" do
    get login_path
    assert_template "users/login_form"
    post login_path, params: { email: users(:one).email, password: "password" }
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
    assert is_logged_in?
  end
end
