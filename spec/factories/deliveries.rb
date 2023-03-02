FactoryBot.define do
  factory :delivery do
    from_days { rand(5..15) }
    to_days { rand(15..30) }
    price { rand(20..100) }
  end
end
