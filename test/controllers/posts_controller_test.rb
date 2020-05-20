require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  # Before Login
  test "get index before login" do
    get "/posts/index"
    assert_response :success
    assert_template "posts/index"
  end

  test "get new before login" do
    get "/posts/new"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "get edit before login" do
    get "/posts/#{@post.id}/edit"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "get show before login" do
    get "/posts/#{@post.id}"
    assert_response :success
    assert_template "posts/show"
  end

  test "post create before login" do
    post "/posts/create", params: { comment: "Test Comment.", image: fixture_file_upload("test/fixtures/files/cat.jpg") }, headers: { 'content-type': "multipart/form-data" }
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "post update before login" do
    post "/posts/#{@post.id}/update", params: { comment: "Test Comment.", image: fixture_file_upload("test/fixtures/files/cat.jpg") }, headers: { 'content-type': "multipart/form-data" }
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "post destroy before login" do
    post "/posts/#{@post.id}/destroy"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  # After Login
  test "get index after login" do
    login(:one)
    get "/posts/index"
    assert_response :success
    assert_template "posts/index"
  end

  test "get new after login" do
    login(:one)
    get "/posts/new"
    assert_response :success
    assert_template "posts/new"
  end

  test "get edit after login" do
    login(:one)
    get "/posts/#{@post.id}/edit"
    assert_response :success
    assert_template "posts/edit"
  end

  test "get show after login" do
    login(:one)
    get "/posts/#{@post.id}"
    assert_response :success
    assert_template "posts/show"
  end

  test "post create after login" do
    login(:one)
    post "/posts/create", params: { comment: "Test Comment.", image: fixture_file_upload("test/fixtures/files/cat.jpg") }, headers: { 'content-type': "multipart/form-data" }
    assert_response :redirect
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end

  test "post update after login" do
    login(:one)
    post "/posts/#{@post.id}/update", params: { comment: "Test Comment.", image: fixture_file_upload("test/fixtures/files/cat.jpg") }, headers: { 'content-type': "multipart/form-data" }
    assert_response :redirect
    assert_redirected_to "/posts/#{@post.id}"
    follow_redirect!
    assert_template "posts/show"
  end

  test "post destroy after login" do
    login(:one)
    post "/posts/#{@post.id}/destroy"
    assert_response :redirect
    assert_redirected_to "/posts/index"
    follow_redirect!
    assert_template "posts/index"
  end
end
