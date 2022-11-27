class SortingService
  attr_reader :params, :books

  SORT_BOOKS = {
    newest_first: ->(instance) { instance.order_by('id DESC') },
    asc_price: ->(instance) { instance.order_by('price ASC') },
    desc_price: ->(instance) { instance.order_by('price DESC') },
    asc_title: ->(instance) { instance.order_by('title ASC') },
    desc_title: ->(instance) { instance.order_by('title DESC') }
  }.freeze

  def initialize(books, params)
    @books = books
    @params = params
  end

  def call
    sort_books
  end

  def sort_books
    params[:sort_by] = :newest_first unless SORT_BOOKS.include?(params[:sort_by]&.to_sym)

    SORT_BOOKS[params[:sort_by].to_sym].call(self)
  end

  def order_by(by)
    select_books_by_category.order(by)
  end

  def select_books_by_category
    return books unless params[:category_id]

    books.where(category_id: params[:category_id])
  end
end
