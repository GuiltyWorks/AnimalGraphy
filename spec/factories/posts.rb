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
FactoryBot.define do
  factory :post do
    sequence(:comment) { |n| "Test Comment #{n}" }
    sequence(:user_id) { |n| n }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/files/cat.jpg")) }
    association :user

    # after(:create) do |post|
    #   create(:tag, post_id: post.id)
    # end
  end
end
