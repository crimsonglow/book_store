class BooksController < ApplicationController
  include Pagy::Backend

  COUNT_PAGE_BOOKS = 12

  def index
    # binding.pry
    @sorted_books = SortingService.new(Book.all, params).call
    @books_presenter = BooksPresenter.new(params: params)
    @pagy, @books_category = pagy(@sorted_books, items: COUNT_PAGE_BOOKS)
  end

  def show
    @current_book = Book.find_by(id: params[:id].to_i)
    @review_presenter = ReviewPresenter.new(current_book: @current_book)
    @current_book_presenter = CurrentBookPresenter.new(current_book: @current_book)
  end

  def create
    Book.create(photo_params)
    binding.pry

    # - @book1 = Book.last
    # = image_tag @book1.image_url
    # - @book = Book.new
    # = form_for @book do |f|
    #     = f.hidden_field :image, value: @book.cached_image_data
    #     = f.file_field :image
    #     = f.submit

  end

  private

  def photo_params
    params.require(:book).permit(:image, :category_id)
  end
end
