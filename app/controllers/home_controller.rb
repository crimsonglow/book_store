class HomeController < ApplicationController
  def index
    @books_presenter = BooksPresenter.new(params: params)
  end
end
