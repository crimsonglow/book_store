FactoryBot.define do
  factory :category do
    name { 'Mobile development' }
  end

  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description(5) }
    price { rand(10...99.99).round(2) }
    published_year { 2016 }
    heigth { 6.4 }
    width { 0.9 }
    depth { 5.0 }
    material { 'Hardcove, glossy paper' }

    category
  end

  factory :review do
    title { FFaker::Lorem.word }
    text_review { FFaker::Lorem.word }

    user
    book
  end

  factory :book_image do
    book_id { book.id }
    image { File.open('app/assets/images/default.png') }
    image_type { 'additional' }
  end
end
