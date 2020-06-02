FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test#{n}" }
    sequence(:email) { |n| "test#{n}@testmail.com" }
    image_name { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/files/cat.jpg")) }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Date.today }

    after(:create) do |user|
      create_list(:post, 3, user: user)
    end
  end
end
