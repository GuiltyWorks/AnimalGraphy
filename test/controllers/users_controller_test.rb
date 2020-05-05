require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  # Before Login
  test "get login before login" do
    get login_path
    assert_template "users/login_form"
    assert_response :success
  end

  test "get signup before login" do
    get signup_path
    assert_template "users/new"
    assert_response :success
  end

  test "get index before login" do
    get "/users/index"
    assert_template "users/index"
    assert_response :success
  end

  test "get edit before login" do
    get "/users/1/edit"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "get likes before login" do
    get "/users/1/likes"
    assert_template "users/likes"
    assert_response :success
  end

  test "get show before login" do
    get "/users/1"
    assert_template "users/show"
    assert_response :success
  end

  test "get delete before login" do
    get "/users/1/delete"
    assert_template "users/delete"
    assert_response :success
  end

  test "post create before login" do
    post "/users/create", params: { name: "Test", email: "test@testmail.com", password: "password" }
    follow_redirect!
    assert_template "users/show"
  end

  test "post update before login" do
    post "/users/1/update", params: { name: "Test", email: "test@testmail.com" }
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "post destroy before login" do
    post "/users/1/destroy"
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  # After Login
  test "get login after login" do
    login
    get login_path
    assert_response :redirect
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end

  test "get signup after login" do
    login
    get signup_path
    assert_response :redirect
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end

  test "get index after login" do
    login
    get "/users/index"
    assert_template "users/index"
    assert_response :success
  end

  test "get edit after login" do
    login
    get "/users/#{session[:user_id]}/edit"
    assert_template "users/edit"
    assert_response :success
  end

  test "get likes after login" do
    login
    get "/users/#{session[:user_id]}/likes"
    assert_template "users/likes"
    assert_response :success
  end

  test "get show after login" do
    login
    get "/users/#{session[:user_id]}"
    assert_template "users/show"
    assert_response :success
  end

  test "get delete after login" do
    login
    get "/users/1/delete"
    assert_template "users/delete"
    assert_response :success
  end

  test "post create after login" do
    login
    post "/users/create", params: { name: "Test", email: "test@testmail.com", password: "password" }
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end

  test "post update after login" do
    login
    post "/users/#{session[:user_id]}/update", params: { name: "Test", email: "test@testmail.com" }
    assert_redirected_to "/users/#{session[:user_id]}"
    follow_redirect!
    assert_template "users/show"
  end

  test "post destroy after login" do
    login
    post "/users/#{session[:user_id]}/destroy"
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end
end
