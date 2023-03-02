class TopBooksBaseQuery
  def select_books(books, action)
    books.joins("JOIN (#{action}) subquery ON subquery.book_id = books.id")
         .order('subquery.quantity DESC, books.id desc')
  end

  def request_tob_book_from_each_category
    <<~SQL
      SELECT * FROM (
      SELECT S.*, ROW_NUMBER() OVER (partition by category_id order by quantity DESC) row_num
      FROM (#{books_have_been_bought}) s ) s
      WHERE row_num <= 1
      ORDER BY category_id, quantity DESC
    SQL
  end

  def books_have_been_bought
    LineItem
      .joins(:order, :book)
      .where(orders: { status: ['complete', 6, 7] })
      .group(:category_id, :book_id).select('category_id, SUM(quantity) AS quantity, book_id').to_sql
  end
end
