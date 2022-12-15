class ApplicationPresenter < Rectify::Presenter
  def main_image_or_default(book)
    main_image = book.book_images.main
    main_image.present? ? main_image.first.image_url : default_image
  end

  def additional_image(book)
    additional_image = book.book_images.additional
    additional_image.present? ? additional_image.map(&:image_url) : [default_image, default_image]
  end

  def default_image
    BookImage.new.image_url
  end
end
