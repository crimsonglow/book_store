FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'A1password' }
    confirmed_at { Time.now.iso8601 }
  end
end
