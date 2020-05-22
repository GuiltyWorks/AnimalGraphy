require 'test_helper'

class NewsControllerTest < ActionDispatch::IntegrationTest
  # Before Login
  test "get general before login" do
    get "/news/general"
    assert_response :success
    assert_template "news/index"
  end

  test "get bird before login" do
    get "/news/bird"
    assert_response :success
    assert_template "news/index"
  end

  test "get cat before login" do
    get "/news/cat"
    assert_response :success
    assert_template "news/index"
  end

  test "get dog before login" do
    get "/news/dog"
    assert_response :success
    assert_template "news/index"
  end

  test "get horse before login" do
    get "/news/horse"
    assert_response :success
    assert_template "news/index"
  end

  test "get sheep before login" do
    get "/news/sheep"
    assert_response :success
    assert_template "news/index"
  end

  test "get cow before login" do
    get "/news/cow"
    assert_response :success
    assert_template "news/index"
  end

  test "get elephant before login" do
    get "/news/elephant"
    assert_response :success
    assert_template "news/index"
  end

  test "get bear before login" do
    get "/news/bear"
    assert_response :success
    assert_template "news/index"
  end

  test "get zebra before login" do
    get "/news/zebra"
    assert_response :success
    assert_template "news/index"
  end

  test "get giraffe before login" do
    get "/news/giraffe"
    assert_response :success
    assert_template "news/index"
  end

  # After Login
  test "get general after login" do
    login(:one)
    get "/news/general"
    assert_response :success
    assert_template "news/index"
  end

  test "get bird after login" do
    login(:one)
    get "/news/bird"
    assert_response :success
    assert_template "news/index"
  end

  test "get cat after login" do
    login(:one)
    get "/news/cat"
    assert_response :success
    assert_template "news/index"
  end

  test "get dog after login" do
    login(:one)
    get "/news/dog"
    assert_response :success
    assert_template "news/index"
  end

  test "get horse after login" do
    login(:one)
    get "/news/horse"
    assert_response :success
    assert_template "news/index"
  end

  test "get sheep after login" do
    login(:one)
    get "/news/sheep"
    assert_response :success
    assert_template "news/index"
  end

  test "get cow after login" do
    login(:one)
    get "/news/cow"
    assert_response :success
    assert_template "news/index"
  end

  test "get elephant after login" do
    login(:one)
    get "/news/elephant"
    assert_response :success
    assert_template "news/index"
  end

  test "get bear after login" do
    login(:one)
    get "/news/bear"
    assert_response :success
    assert_template "news/index"
  end

  test "get zebra after login" do
    login(:one)
    get "/news/zebra"
    assert_response :success
    assert_template "news/index"
  end

  test "get giraffe after login" do
    login(:one)
    get "/news/giraffe"
    assert_response :success
    assert_template "news/index"
  end
end
