require "rails_helper"

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }

  it "is valid with user_id and post_id" do
    expect(like.valid?).to eq(true)
  end

  it "is invalid without user_id" do
    like.user_id = nil
    expect(like.valid?).to eq(false)
  end

  it "is invalid without post_id" do
    like.user_id = nil
    expect(like.valid?).to eq(false)
  end
end
