FactoryBot.define do
  factory :order do
    user
    number do
      Array.new(ConfirmService::LENGTH_SECRET_NUMBER) do
        [rand(ConfirmService::RANGE_SECRET_NUMBER)]
      end.unshift(ConfirmService::BEGIN_SECRET_NUMBER).join
    end

    after(:create) do |order|
      create(:line_item, order_id: order.id)
    end

    trait :in_cart do
      status { 'cart' }
    end

    trait :address_step do
      status { 'address' }
    end

    trait :fill_delivery_step do
      status { 'fill_delivery' }
    end

    trait :payment_step do
      after(:create) do |order|
        order.addresses.create!(attributes_for(:address, :billing))
        order.addresses.create!(attributes_for(:address, :shipping))
      end

      status { 'payment' }
    end

    trait :confirm_step do
      after(:create) do |order|
        order.addresses.create!(attributes_for(:address, :billing))
        order.addresses.create!(attributes_for(:address, :shipping))
        create(:credit_card, order_id: order.id)
      end

      status { 'confirm' }
    end

    trait :complete_step do
      after(:create) do |order|
        order.addresses.create!(attributes_for(:address, :billing))
        order.addresses.create!(attributes_for(:address, :shipping))
        create(:credit_card, order_id: order.id)
      end

      status { 'complete' }
    end

    trait :in_delivery do
      status { Order.statuses[:in_delivery] }
    end

    trait :delivered do
      status { Order.statuses[:delivered] }
    end

    trait :canceled do
      status { Order.statuses[:canceled] }
    end
  end
end
