require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is valid with name and email and image_name and password" do
    expect(user.valid?).to eq(true)
  end

  it "is invalid without name" do
    user.name = ""
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid without email" do
    user.email = ""
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid without password" do
    user.password = ""
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "is invalid without image_name" do
    user.image_name = nil
    expect(user.valid?).to eq(true)
  end

  it "is invalid with a duplicate email" do
    user.save
    @duplicate_user = build(:user)
    @duplicate_user.email = user.email
    @duplicate_user.valid?
    expect(@duplicate_user.errors[:email]).to include("はすでに存在します")
  end
end
