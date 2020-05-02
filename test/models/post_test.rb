require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post_1 = Post.new(user_id: nil, comment: nil)
    @post_2 = Post.new(user_id: nil, comment: "Test Comment.")
    @post_3 = Post.new(user_id: 1, comment: nil)
    @post_4 = Post.new(user_id: 1, comment: "Test Comment.")
  end

  test "create post" do
    assert_not @post_1.valid?
    assert_not @post_2.valid?
    assert_not @post_3.valid?
    assert @post_4.valid?
  end
end
