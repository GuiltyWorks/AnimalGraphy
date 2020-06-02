require "test_helper"

class LikeTest < ActiveSupport::TestCase
  def setup
    @like_1 = Like.new(user_id: nil, post_id: nil)
    @like_2 = Like.new(user_id: nil, post_id: 1)
    @like_3 = Like.new(user_id: 1, post_id: nil)
    @like_4 = Like.new(user_id: 1, post_id: 1)
  end

  test "create like" do
    assert_not @like_1.valid?
    assert_not @like_2.valid?
    assert_not @like_3.valid?
    assert @like_4.valid?
  end
end
