class CartsController < ApplicationController
  def index
    @books_presenter = BooksPresenter.new(params: params)
    @cart_presenter = CartPresenter.new(current_order: current_order)
    @cart_books = current_order&.books
  end
end
