# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class TagTest < ActiveSupport::TestCase
  def setup
    @tag_1 = Tag.new(post_id: nil)
    @tag_2 = Tag.new(post_id: 1)
    @tag_3 = Tag.new(post_id: nil, bird: true, cat: true, dog: true, horse: true, sheep: true, cow: true, elephant: true, bear: true, zebra: true, giraffe: true)
    @tag_4 = Tag.new(post_id: nil, bird: false, cat: false, dog: false, horse: false, sheep: false, cow: false, elephant: false, bear: false, zebra: false, giraffe: false)
    @tag_5 = Tag.new(post_id: 1, bird: true, cat: true, dog: true, horse: true, sheep: true, cow: true, elephant: true, bear: true, zebra: true, giraffe: true)
    @tag_6 = Tag.new(post_id: 1, bird: false, cat: false, dog: false, horse: false, sheep: false, cow: false, elephant: false, bear: false, zebra: false, giraffe: false)
    @tag_7 = Tag.new(post_id: nil, cat: false)
    @tag_8 = Tag.new(post_id: 1, cat: true)
  end

  test "create tag" do
    assert_not @tag_1.valid?
    assert @tag_2.valid?
    assert_not @tag_3.valid?
    assert_not @tag_4.valid?
    assert @tag_5.valid?
    assert @tag_6.valid?
    assert_not @tag_7.valid?
    assert @tag_8.valid?
  end
end
