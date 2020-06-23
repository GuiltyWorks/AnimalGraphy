# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }

  it "is valid with name" do
    expect(tag.valid?).to eq true
  end

  it "is invalid without name" do
    tag.name = ""
    expect(tag.valid?).to eq false
    expect(tag.errors[:name]).to include "を入力してください"
  end

  it "is invalid with a duplicate name" do
    duplicate_tag = build(:tag, name: tag.name)
    expect(duplicate_tag.valid?).to eq false
    expect(duplicate_tag.errors[:name]).to include "はすでに存在します"
  end
end
