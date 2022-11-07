class CurrentBookPresenter < Rectify::Presenter
  attribute :current_book, Book

  VISIBLE_LENGTH_DESCRIPTION_BOOK = 100

  def all_categories
    Category.all
  end

  def desctiption_length_valid?
    current_book.description.length > VISIBLE_LENGTH_DESCRIPTION_BOOK
  end

  def show_all_description_text
    current_book.description
  end

  def show_description
    current_book.description[0..VISIBLE_LENGTH_DESCRIPTION_BOOK]
  end
end
