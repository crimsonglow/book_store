class PaymentPresenter < ApplicationPresenter
  attribute :params
  attribute :current_order
  attribute :form
  STEP = :payment

  def payment_card
    form || CreditCardForm.new
  end

  def current_card
    current_order.credit_card
  end
end
