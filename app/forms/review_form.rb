class ReviewForm
  include ActiveModel::Model
  include Virtus

  attribute :title, String
  attribute :text_review, String
  attribute :current_user, Integer
  attribute :current_book, Integer
  attribute :rating, Integer

  validates :title, presence: true, length: { maximum: 80 }
  validates :text_review, presence: true, length: { maximum: 500 }
end
