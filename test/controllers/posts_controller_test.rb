require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  # Before Login
  test "get index before login" do
    get "/posts/index"
    assert_template "posts/index"
    assert_response :success
  end

  test "get new before login" do
    get "/posts/new"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "get edit before login" do
    get "/posts/1/edit"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "get show before login" do
    get "/posts/1"
    assert_template "posts/show"
    assert_response :success
  end

  test "post create before login" do
    post "/posts/create", params: { comment: "Test Comment.", image: fixture_file_upload("test/fixtures/files/cat.jpg") }, headers: { 'content-type': "multipart/form-data" }
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "post update before login" do
    post "/posts/1/update", params: { id: @user.id, comment: "Test Comment." }
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "post destroy before login" do
    post "/posts/1e/destroy"
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  # After Login
  test "get index after login" do
    login
    get "/posts/index"
    assert_template "posts/index"
    assert_response :success
  end

  test "get new after login" do
    login
    get "/posts/new"
    assert_template "posts/new"
    assert_response :success
  end

  test "get edit after login" do
    login
    get "/posts/1/edit"
    assert_template "posts/edit"
    assert_response :success
  end

  test "get show after login" do
    login
    get "/posts/1"
    assert_template "posts/show"
    assert_response :success
  end

  test "post create after login" do
    login
    post "/posts/create", params: { comment: "Test Comment.", image: fixture_file_upload("test/fixtures/files/cat.jpg") }, headers: { 'content-type': "multipart/form-data" }
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end

  test "post update after login" do
    login
    post "/posts/1/update", params: { id: @user.id, comment: "Test Comment." }
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end

  test "post destroy after login" do
    login
    post "/posts/1/destroy"
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end
end
