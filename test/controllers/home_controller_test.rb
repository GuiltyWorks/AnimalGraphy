require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  # Before Login
  test "get root before login" do
    get root_path
    assert_response :success
    assert_template "home/top"
  end

  test "get top before login" do
    get "/"
    assert_response :success
    assert_template "home/top"
  end

  test "get about before login" do
    get about_path
    assert_response :success
    assert_template "home/about"
  end

  # After Login
  test "get root after login" do
    login(:one)
    get root_path
    assert_response :success
    assert_template "home/top"
  end

  test "get top after login" do
    login(:one)
    get "/"
    assert_response :success
    assert_template "home/top"
  end

  test "get about after login" do
    login(:one)
    get about_path
    assert_response :success
    assert_template "home/about"
  end
end
