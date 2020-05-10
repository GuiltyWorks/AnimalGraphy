require "test_helper"

class UserOperationTest < ActionDispatch::IntegrationTest
  test "signup and logout and login and create post" do
    # signup
    get signup_path
    assert_response :success
    assert_template "users/new"
    assert_difference "User.count" do
      post "/users/create", params: { name: "valid", email: "valid@validmail.com", password: "password" }
    end
    assert_response :redirect
    assert_redirected_to "/users/#{session[:user_id]}"
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?

    # logout
    post logout_path
    assert_response :redirect
    assert_redirected_to login_path
    follow_redirect!
    assert_template "users/login_form"

    # login
    get login_path
    assert_response :success
    assert_template "users/login_form"
    post login_path, params: { email: "valid@validmail.com", password: "password" }
    assert_response :redirect
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
    assert is_logged_in?

    # create post
    get "/posts/new"
    assert_response :success
    assert_template "posts/new"
    assert_difference "Post.count" do
      post "/posts/create", params: { comment: "Test Comment.", image: fixture_file_upload("test/fixtures/files/cat.jpg") }, headers: { 'content-type': "multipart/form-data" }
    end
    assert_response :redirect
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end
end
