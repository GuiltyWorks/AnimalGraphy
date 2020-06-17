# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post_1 = Post.new(user_id: nil, comment: nil, image_name: nil)
    @post_2 = Post.new(user_id: nil, comment: nil, image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')))
    @post_3 = Post.new(user_id: nil, comment: "Test Comment.", image_name: nil)
    @post_4 = Post.new(user_id: nil, comment: "Test Comment.", image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')))
    @post_5 = Post.new(user_id: 1, comment: nil, image_name: nil)
    @post_6 = Post.new(user_id: 1, comment: nil, image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')))
    @post_7 = Post.new(user_id: 1, comment: "Test Comment.", image_name: nil)
    @post_8 = Post.new(user_id: 1, comment: "Test Comment.", image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')))
    @post_9 = Post.new(
      user_id: 1,
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
      image_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/cat.jpg')),
    )
  end

  test "create post" do
    assert_not @post_1.valid?
    assert_not @post_2.valid?
    assert_not @post_3.valid?
    assert_not @post_4.valid?
    assert_not @post_5.valid?
    assert_not @post_6.valid?
    assert_not @post_7.valid?
    assert @post_8.valid?
    assert_not @post_9.valid?
  end
end
