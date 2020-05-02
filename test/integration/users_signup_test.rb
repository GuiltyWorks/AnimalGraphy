require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "signup with invalid information" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post "/users/create", params: { name: "", email: "invalid@invalidmail.com", password: "invalid" }
    end
    assert_not is_logged_in?
  end

  test "signup with valid information" do
    get signup_path
    assert_template "users/new"
    assert_difference "User.count" do
      post "/users/create", params: { name: "valid", email: "valid@validmail.com", password: "password" }
    end
    assert_redirected_to "/users/#{session[:user_id]}"
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
  end
end
