class AddressForm
  include ActiveModel::Model
  include Virtus

  VALIDATE_CONSIST_LETTERS = /\A[a-z A-Z]+\z/.freeze
  VALIDATE_ZIP = /\A[0-9]+\z/.freeze
  VALIDATE_PHONE = /\A^\+[0-9]+\z/.freeze
  VALIDATE_ADDRESS = /\A[a-z A-Z,\d,-]+\z/.freeze

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, Integer
  attribute :country, String
  attribute :phone, String
  attribute :address_type, String

  attribute :user_id, Integer
  attribute :order_id, Integer

  validates :first_name, :last_name, :address, :country, :city, :zip, :phone, :address_type, presence: true
  validates :first_name, :last_name, :address, :country, :city,
            length: { maximum: 50, message: I18n.t('validate.no_more_50') }
  validates :first_name, :last_name, :country, :city,
            format: { with: VALIDATE_CONSIST_LETTERS, message: I18n.t('validate.consist_letters') }
  validates :zip, length: { maximum: 10, message: I18n.t('validate.no_more_10') }
  validates :zip, format: { with: VALIDATE_ZIP, message: I18n.t('validate.wrong_number') }
  validates :phone, length: { maximum: 15, message: I18n.t('validate.no_more_15') }
  validates :phone, format: { with: VALIDATE_PHONE, message: I18n.t('validate.start_plus') }
  validates :address, format: { with: VALIDATE_ADDRESS, message: I18n.t('validate.wrong_address') }
end
