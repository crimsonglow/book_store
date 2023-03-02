class EmailForm
  include ActiveModel::Model
  include Virtus.model

  attribute :email, String
  attribute :user_id, Integer

  validates :email, :user_id, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
