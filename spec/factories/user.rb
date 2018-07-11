FactoryBot.define do
  factory :user do
    uid { SecureRandom.urlsafe_base64 }
    sequence(:email) { |n| "user#{n}@example.com" }
  end
end
