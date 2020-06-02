require "rails_helper"

RSpec.describe Reply, type: :model do
  let(:reply) { create(:reply) }

  it "is valid with user_id and post_id and comment" do
    expect(reply.valid?).to eq(true)
  end

  it "is invalid without user_id" do
    reply.user_id = nil
    expect(reply.valid?).to eq(false)
  end

  it "is invalid without post_id" do
    reply.user_id = nil
    expect(reply.valid?).to eq(false)
  end

  it "is invalid without comment" do
    reply.comment = ""
    reply.valid?
    expect(reply.errors[:comment]).to include("を入力してください")
  end

  it "is invalid with comment over 1000 characters" do
    reply.comment = "
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
    "
    reply.valid?
    expect(reply.errors[:comment]).to include("は1000文字以内で入力してください")
  end
end
