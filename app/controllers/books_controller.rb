class BooksController < ApplicationController
  include Pagy::Backend

  COUNT_PAGE_BOOKS = 12

  def index
    @sorted_books = SortingService.new(Book.all, params).call
    @books_presenter = BooksPresenter.new(params: params)
    @pagy, @books_category = pagy(@sorted_books, items: COUNT_PAGE_BOOKS)
  end
end
