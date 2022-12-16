class TopBooksByCategoryQuery < TopBooksBaseQuery
  def call(books)
    select_books(books, books_have_been_bought)
  end
end
