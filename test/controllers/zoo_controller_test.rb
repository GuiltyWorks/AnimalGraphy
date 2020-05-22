require 'test_helper'

class ZooControllerTest < ActionDispatch::IntegrationTest
  # Before Login
  test "get zoo before login" do
    get "/zoo"
    assert_response :success
    assert_template "zoo/index"
  end

  # After Login
  test "get zoo after login" do
    login(:one)
    get "/zoo"
    assert_response :success
    assert_template "zoo/index"
  end
end
