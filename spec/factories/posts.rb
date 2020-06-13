FactoryBot.define do
  factory :post do
    sequence(:comment) { |n| "Test Comment #{n}" }
    sequence(:user_id) { |n| n }
    image_name { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/files/cat.jpg")) }
    association :user

    after(:create) do |post|
      create(:tag, post_id: post.id)
    end
  end
end
