class TopBooksQuery
  def call(category_id: '')
    sql = category_id.present? ? by_category(category_id) : each_category
    Book.where("id IN (SELECT id FROM (#{sql}) S)")
  end

  private

  def by_category(category_id)
    <<~SQL
      SELECT S.*, b.id, b.title, b.price FROM (
      SELECT S.* FROM (#{subquery.to_sql}) s
      WHERE category_id in(#{category_id}) ) S
      JOIN books b on b.id = S.book_id
      ORDER BY category_id, quantity DESC, book_id
    SQL
  end

  def each_category
    <<~SQL
      SELECT S.*, b.id, b.title, b.price FROM (
      SELECT * FROM (
      SELECT S.*, ROW_NUMBER() OVER (partition by category_id order by quantity DESC) row_num
      FROM (#{subquery.to_sql}) s ) s
      WHERE row_num <= 1) S
      JOIN books b on b.id = S.book_id
      ORDER BY category_id, quantity DESC
    SQL
  end

  def subquery
    LineItem
      .joins(:order, :book)
      .where(orders: { status: ['complete', 6, 7] })
      .group(:category_id, :book_id).select('category_id, SUM(quantity) AS quantity, book_id')
  end
end
