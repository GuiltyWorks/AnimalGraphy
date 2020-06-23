# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  description            :text(65535)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  image                  :string(255)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  name                   :string(255)
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  uid                    :string(255)
#  unconfirmed_email      :string(255)
#  unlock_token           :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is valid with name and email and image_name and password" do
    expect(user.valid?).to eq true
  end

  it "is invalid without name" do
    user.name = ""
    expect(user.valid?).to eq false
    expect(user.errors[:name]).to include "を入力してください"
  end

  it "is invalid without email" do
    user.email = ""
    expect(user.valid?).to eq false
    expect(user.errors[:email]).to include "を入力してください"
  end

  it "is invalid without password" do
    user.password = ""
    expect(user.valid?).to eq false
    expect(user.errors[:password]).to include "を入力してください"
  end

  it "is invalid without image_name" do
    user.image = nil
    expect(user.valid?).to eq true
  end

  it "is invalid with a duplicate email" do
    user.save
    @duplicate_user = build(:user, email: user.email)
    expect(@duplicate_user.valid?).to eq false
    expect(@duplicate_user.errors[:email]).to include "はすでに存在します"
  end
end
