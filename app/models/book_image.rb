class BookImage < ApplicationRecord
  include ImageUploader::Attachment(:image)
  before_save :image_derivatives
  enum image_type: { main: 0, additional: 1 }

  belongs_to :book, optional: true

  validate :main_image

  private

  def main_image
    return unless book
    return unless book.book_images.main.present? && image_type == 'main'

    errors.add :image_type, I18n.t('validate.main_image')
  end

  def image_derivatives
    image_derivatives!
  end
end
