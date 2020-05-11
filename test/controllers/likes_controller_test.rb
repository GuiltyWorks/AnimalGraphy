require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  # Before Login
  test "post create before login" do
    post "/likes/#{@post.id}/create"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  test "post destroy before login" do
    post "/likes/#{@post.id}/destroy"
    assert_response :redirect
    assert_redirected_to "/login"
    follow_redirect!
    assert_template "users/login_form"
  end

  # After Login
  test "post create after login" do
    login(:one)
    post "/likes/#{@post.id}/create"
    assert_response :redirect
    assert_redirected_to "/posts/#{@post.id}"
    follow_redirect!
    assert_template "posts/show"
  end

  test "post destroy after login" do
    login(:one)
    post "/likes/#{@post.id}/destroy"
    assert_response :redirect
    assert_redirected_to "/posts/#{@post.id}"
    follow_redirect!
    assert_template "posts/show"
  end
end
