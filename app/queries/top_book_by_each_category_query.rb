class TopBookByEachCategoryQuery < TopBooksBaseQuery
  def call
    select_books(Book.all, request_tob_book_from_each_category)
  end
end
