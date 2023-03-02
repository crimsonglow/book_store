class PaymentService
  attr_reader :params, :current_order, :current_user

  def initialize(params, current_user, current_order)
    @params = params
    @current_order = current_order
    @current_user = current_user
  end

  def call
    return unless form.valid?

    create_or_update_card
  end

  def create_or_update_card
    current_order.credit_card ? update_credit_card : create_credit_card
  end

  def create_credit_card
    CreditCard.new(form.attributes).save
  end

  def update_credit_card
    current_order.credit_card.update(form.attributes.without(:order_id))
  end

  def form
    @form ||= CreditCardForm.new(params[:credit_card_form])
  end

  def presenter
    PaymentPresenter.new(params: params, current_order: current_order, form: form)
  end
end
