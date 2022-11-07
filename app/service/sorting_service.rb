class SortingService < ApplicationController
  attr_reader :params, :books

  SORT_BOOKS = {
    asc_title: ->(instance) { instance.sort_choice('name ASC') },
    desc_title: ->(instance) { instance.sort_choice('name DESC') },
    asc_price: ->(instance) { instance.sort_choice('price ASC') },
    desc_price: ->(instance) { instance.sort_choice('price DESC') },
    newest_first: ->(instance) { instance.sort_choice('id DESC') }
  }.freeze

  def initialize(books, params)
    @books = books
    @params = params
  end

  def call
    @books_category = select_books_by_category
    sort_books
  end

  def sort_books
    params[:sort_by] = :asc_title unless SORT_BOOKS.include?(params[:sort_by]&.to_sym)

    @books_category = SORT_BOOKS[params[:sort_by].to_sym].call(self)
  end

  def sort_choice(item)
    @books_category = @books_category.order(item)
  end

  def select_books_by_category
    books_chosen_category = books.where(category_id: params[:category_id].to_i)
    books_chosen_category.presence || books
  end
end
