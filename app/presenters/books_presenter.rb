class BooksPresenter < Rectify::Presenter
  attribute :params

  COUNT_NEW_BOOKS = 3

  def all_books
    Book.all
  end

  def all_categories
    Category.all
  end

  def new_books_slider
    all_books.last(COUNT_NEW_BOOKS)
  end

  def top_books
  end

  def show_sort_type
    params[:sort_by] ? t("sort_books.#{params[:sort_by]}") : t('sort_books.newest_first')
  end

  def show_img
    image_tag book.image_url
  end
end
