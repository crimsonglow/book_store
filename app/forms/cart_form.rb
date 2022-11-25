class CartForm
  include ActiveModel::Model
  include Virtus

  attribute :current_book, Integer

  validates :current_book, presence: true
end
