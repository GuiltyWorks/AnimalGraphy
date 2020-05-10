ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login(login_user)
    post login_path, params: { email: users(login_user).email, password: "password" }
    assert_response :redirect
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end

  def is_logged_in?
    !session[:user_id].nil?
  end
end
