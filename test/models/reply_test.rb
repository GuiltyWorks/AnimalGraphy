require "test_helper"

class ReplyTest < ActiveSupport::TestCase
  def setup
    @reply_1 = Reply.new(user_id: nil, post_id: nil, comment: nil)
    @reply_2 = Reply.new(user_id: nil, post_id: nil, comment: "Test Comment.")
    @reply_3 = Reply.new(user_id: nil, post_id: 1, comment: nil)
    @reply_4 = Reply.new(user_id: nil, post_id: 1, comment: "Test Comment.")
    @reply_5 = Reply.new(user_id: 1, post_id: nil, comment: nil)
    @reply_6 = Reply.new(user_id: 1, post_id: nil, comment: "Test Comment.")
    @reply_7 = Reply.new(user_id: 1, post_id: 1, comment: nil)
    @reply_8 = Reply.new(user_id: 1, post_id: 1, comment: "Test Comment.")
    @reply_9 = Reply.new(
      user_id: 1,
      post_id: 1,
      comment: "
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
        Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words. Test Comment Over 1000 Words.
      ",
    )
  end

  test "create post" do
    assert_not @reply_1.valid?
    assert_not @reply_2.valid?
    assert_not @reply_3.valid?
    assert_not @reply_4.valid?
    assert_not @reply_5.valid?
    assert_not @reply_6.valid?
    assert_not @reply_7.valid?
    assert @reply_8.valid?
    assert_not @reply_9.valid?
  end
end
