class ReviewForm
  include ActiveModel::Model
  include Virtus.model

  VALIDATE_REVIEW = %r{\A[\w\s!\#$%&'*+\-/=?\^_`{|}~.]+\z}.freeze

  attribute :title, String
  attribute :text_review, String
  attribute :current_user, Integer
  attribute :current_book, Integer
  attribute :rating, Integer

  validates :title, :text_review, format: { with: VALIDATE_REVIEW, message: I18n.t('validate.validate_review') }
  validates :title, presence: true, length: { maximum: 80 }
  validates :text_review, presence: true, length: { maximum: 500 }
end
