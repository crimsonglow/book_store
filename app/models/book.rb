class Book < ApplicationRecord
  belongs_to :category
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, dependent: nil
  has_many :reviews, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :book_images, dependent: :destroy
end
