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
require "rails_helper"

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  it "is valid with comment and user_id and image" do
    expect(post.valid?).to eq true
  end

  it "is invalid without comment" do
    post.comment = ""
    expect(post.valid?).to eq false
    expect(post.errors[:comment]).to include "を入力してください"
  end

  it "is invalid without user_id" do
    post.user_id = nil
    expect(post.valid?).to eq false
  end

  it "is invalid without image" do
    post.image = nil
    expect(post.valid?).to eq false
    expect(post.errors[:image]).to include "を入力してください"
  end

  it "is invalid with comment over 1000 characters" do
    post.comment = "
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
      Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters. Test Comment Over 1000 Characters.
    "
    expect(post.valid?).to eq false
    expect(post.errors[:comment]).to include "は1000文字以内で入力してください"
  end
end
