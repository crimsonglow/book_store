class CreditCardForm
  include ActiveModel::Model
  include Virtus.model

  VALIDATE_DATE = %r{\A^(0[1-9]|1[0-2])/?([0-9]{2})$\z}.freeze

  attribute :number, Integer
  attribute :name, String
  attribute :date, String
  attribute :cvv, Integer
  attribute :order_id, Integer

  validates :number, :name, :date, :cvv, :order_id, presence: true
  validates :number, numericality: { only_integer: true, message: I18n.t('validate.only_numbers') }
  validates :name, length: { maximum: 50 }
  validates :date, format: { with: VALIDATE_DATE, message: I18n.t('validate.mm_yy') }
  validates :cvv, length: { minimum: 3, maximum: 4 },
                  numericality: { only_integer: true, message: I18n.t('validate.only_numbers') }
end
