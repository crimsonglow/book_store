FactoryBot.define do
  factory :address do
    first_name { FFaker::Lorem.word }
    last_name { FFaker::Lorem.word }
    address { FFaker::Lorem.word }
    city { FFaker::Lorem.word }
    zip { 1232 }
    country { FFaker::Lorem.word }
    phone { '+380662717777' }

    trait :billing do
      address_type { 'billing' }
    end

    trait :shipping do
      address_type { 'shipping' }
    end
  end
end
