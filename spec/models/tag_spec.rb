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
  it "is valid with post_id and bird and cat and dog and horse and sheep and cow and elephant and bear and zebra and giraffe" do
    tag = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      elephant: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag.valid?).to eq(true)
  end

  it "is valid without bird and cat and dog and horse and sheep and cow and elephant and bear and zebra and giraffe" do
    tag = create(:tag)
    expect(tag.valid?).to eq(true)
  end

  it "is valid without bird" do
    tag_without_bird = create(
      :tag,
      cat: true,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      elephant: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_bird.valid?).to eq(true)
  end

  it "is valid without cat" do
    tag_without_cat = create(
      :tag,
      bird: true,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      elephant: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_cat.valid?).to eq(true)
  end

  it "is valid without dog" do
    tag_without_dog = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      elephant: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_dog.valid?).to eq(true)
  end

  it "is valid without horse" do
    tag_without_horse = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      sheep: false,
      cow: false,
      elephant: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_horse.valid?).to eq(true)
  end

  it "is valid without sheep" do
    tag_without_sheep = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      cow: false,
      elephant: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_sheep.valid?).to eq(true)
  end

  it "is valid without cow" do
    tag_without_cow = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      sheep: false,
      elephant: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_cow.valid?).to eq(true)
  end

  it "is valid without elephant" do
    tag_without_elephant = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      bear: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_elephant.valid?).to eq(true)
  end

  it "is valid without bear" do
    tag_without_bear = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      elephant: false,
      zebra: false,
      giraffe: false,
    )
    expect(tag_without_bear.valid?).to eq(true)
  end

  it "is valid without zebra" do
    tag_without_zebra = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      elephant: false,
      bear: false,
      giraffe: false,
    )
    expect(tag_without_zebra.valid?).to eq(true)
  end

  it "is valid without giraffe" do
    tag_without_giraffe = create(
      :tag,
      bird: true,
      cat: false,
      dog: false,
      horse: false,
      sheep: false,
      cow: false,
      elephant: false,
      bear: false,
      zebra: false,
    )
    expect(tag_without_giraffe.valid?).to eq(true)
  end
end
