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
    all_books.includes([:authors]).last(COUNT_NEW_BOOKS)
  end

  def main_image_or_default(book, size)
    call_association = book.book_images.main
    default_image = BookImage.new.image_url

    call_association.present? ? call_association.first.image_url(size.to_sym) : default_image
  end

  def top_books; end

  def show_sort_type
    params[:sort_by] ? t("sort_books.#{params[:sort_by]}") : t('sort_books.newest_first')
  end

  def show_img
    image_tag book.image_url
  end
end
