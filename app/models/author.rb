class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors, dependent: nil

  def full_name
    "#{first_name}' '#{last_name}"
  end
end
