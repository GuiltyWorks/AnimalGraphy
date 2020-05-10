require "test_helper"

class RepliesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
    @reply = replies(:one)
  end

  # Before Login
  test "get edit before login" do
    get "/replies/#{@reply.id}/edit"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "reply create before login" do
    post "/replies/#{@post.id}/create", params: { comment: "Test Comment." }
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "reply update before login" do
    post "/replies/#{@reply.id}/update", params: { comment: "Test Comment." }
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "reply destroy before login" do
    post "/replies/#{@reply.id}/destroy"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  # After Login
  test "get edit after login" do
    login(:one)
    get "/replies/#{@reply.id}/edit"
    assert_response :success
    assert_template "replies/edit"
  end

  test "post create after login" do
    login(:one)
    post "/replies/#{@post.id}/create", params: { comment: "Test Comment." }
    assert_response :redirect
    assert_redirected_to "/posts/#{@reply.post_id}"
    follow_redirect!
    assert_template "posts/show"
  end

  test "post update after login" do
    login(:one)
    post "/replies/#{@reply.id}/update", params: { comment: "Test Comment." }
    assert_response :redirect
    assert_redirected_to "/posts/#{@reply.post_id}"
    follow_redirect!
    assert_template "posts/show"
  end

  test "post destroy after login" do
    login(:one)
    post "/replies/#{@reply.id}/destroy"
    assert_response :redirect
    assert_redirected_to "/posts/#{@reply.post_id}"
    follow_redirect!
    assert_template "posts/show"
  end
end
