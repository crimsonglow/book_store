FactoryBot.define do
  factory :credit_card do
    number { FFaker::PhoneNumber.imei }
    name { FFaker::Lorem.word }
    date { '11/22' }
    cvv { 123 }
  end
end
