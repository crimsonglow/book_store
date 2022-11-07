AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

def generate_user
  user = User.create(first_name: FFaker::Name.name, email: FFaker::Internet.email, password: FFaker::Internet.password)
end

def generate_categories
  Category.create(name: 'Mobile development')
  Category.create(name: 'Photo')
  Category.create(name: 'Web disign')
end

def generate_book
Book.create(
  checkbox: 1, title: FFaker::Book.title,
  short_description: FFaker::Book.description(5),
  price: rand(10...99.99).round(2),
  category_id: rand(1..3)
)
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

generate_categories
20.times { generate_book }
20.times { generate_authors }
generate_authors_books
