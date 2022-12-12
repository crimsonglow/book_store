class CurrentBookPresenter < Rectify::Presenter
  attribute :current_book, Book

  VISIBLE_LENGTH_DESCRIPTION_BOOK = 250

  def all_categories
    Category.all
  end

  def desctiption_length_valid?
    current_book.description.length > VISIBLE_LENGTH_DESCRIPTION_BOOK
  end

  def show_all_description_text
    current_book.description
  end

  def main_image_or_default
    call_association = current_book.book_images.main
    default_image = '/default.png'

    call_association.present? ? call_association.first.image_url : default_image
  end

  def additional_image
    current_book.book_images.additional.map(&:image_url)
  end

  def show_description
    current_book.description[0..VISIBLE_LENGTH_DESCRIPTION_BOOK]
  end

  def show_params_current_book
    "H:#{current_book.heigth}\" x W: #{current_book.width}\" x D: #{current_book.depth}"
  end
end
