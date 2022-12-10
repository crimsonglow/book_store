FactoryBot.define do
  factory :order do
    user

    after(:create) do |order|
      create(:line_item, order_id: order.id)
    end

    trait :in_cart do
      status { 'cart' }
    end

    trait :address_step do
      status { 'address' }
    end
  end
end
