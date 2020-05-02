require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  # Before Login
  test "get root before login" do
    get root_path
    assert_template "home/top"
    assert_response :success
  end

  test "get top before login" do
    get "/"
    assert_template "home/top"
    assert_response :success
  end

  test "get about before login" do
    get about_path
    assert_template "home/about"
    assert_response :success
  end

  # After Login
  test "get root after login" do
    login
    get root_path
    assert_template "home/top"
    assert_response :success
  end

  test "get top after login" do
    login
    get "/"
    assert_template "home/top"
    assert_response :success
  end

  test "get about after login" do
    login
    get about_path
    assert_template "home/about"
    assert_response :success
  end
end
