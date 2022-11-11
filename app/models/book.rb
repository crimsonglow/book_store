class Book < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :category
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
end
