FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test#{n}" }
    sequence(:email) { |n| "test#{n}@testmail.com" }
    image_name { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/files/cat.jpg")) }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Date.today }

    trait :with_posts do
      transient do
        posts_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end

    trait :with_replies do
      transient do
        replies_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:reply, evaluator.replies_count, user: user)
      end
    end

    trait :with_likes do
      transient do
        likes_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:like, evaluator.likes_count, user: user)
      end
    end
  end
end
