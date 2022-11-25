class BooksController < ApplicationController
  include Pagy::Backend

  COUNT_PAGE_BOOKS = 12

  def index
    @sorted_books = SortingService.new(Book.all, params).call
    @books_presenter = BooksPresenter.new(params: params)
    @pagy, @books_category = pagy(@sorted_books, items: COUNT_PAGE_BOOKS)
  end

  def show
    @current_book = Book.find_by(id: params[:id].to_i)
    @review_presenter = ReviewPresenter.new(current_book: @current_book)
    @current_book_presenter = CurrentBookPresenter.new(current_book: @current_book)
  end
end
