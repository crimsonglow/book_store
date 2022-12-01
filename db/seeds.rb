require 'ffaker'

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end

def generate_user
  User.create(email: FFaker::Internet.email, password: FFaker::Internet.password)
  User.create(email: 'cyril_hackett@streich.us', password: 'password')
end

def generate_categories
  Category.create(name: 'Mobile development')
  Category.create(name: 'Photo')
  Category.create(name: 'Web disign')
end

def generate_book
  book = Book.new(
    title: FFaker::Book.title,
    description: FFaker::Book.description(5),
    price: rand(10...99.99).round(2),
    category_id: rand(1..3),
    published_year: 2016,
    heigth: 6.4,
    width: 0.9,
    depth: 5.0,
    material: 'Hardcove, glossy paper'
  )

  book.save!
end

def generate_authors
  Author.create(
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
    description: FFaker::Book.description(2)
  )
end

def generate_authors_books
  books = Book.all
  authors = Author.all
  authors_id = authors.map(&:id)

  books.each do |book|
    BookAuthor.create(book_id: book.id, author_id: authors_id[rand(authors_id.length)])
  end
end

def generate_delivery_methods
  Delivery.create(method: 'Express Delivery', from_days: 5, to_days: 10, price: 50)
  Delivery.create(method: 'Standart Delivery', from_days: 10, to_days: 20, price: 25)
end

def generate_coupons
  Coupon.create(key: '12345')
  Coupon.create(key: '22345')
end

generate_categories
15.times { generate_book }
15.times { generate_authors }
generate_authors_books
generate_delivery_methods
generate_coupons
