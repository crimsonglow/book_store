class CheckoutShowService
  attr_reader :params, :current_order, :current_user

  PRESENTERS = {
    address: AddressPresenter,
    fill_delivery: DeliveryPresenter,
    payment: PaymentPresenter,
    confirm: ConfirmPresenter
  }.freeze

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
  end

  def current_presenter
    return quick_registration_presenter unless current_user
    return show_complete_presenter if current_order.complete?

    go_first_step if current_order.cart?
    choose_current_step
  end

  def go_first_step
    current_order.address! && current_order.update(user_id: current_user.id)
  end

  def choose_current_step
    choosen_step = Order.statuses[params[:step]]
    choose_presenter if choosen_step && choosen_step <= Order.statuses[current_order.status]
  end

  def quick_registration_presenter
    QuickRegistrationPresenter.new(params: params, current_order: current_order)
  end

  def show_complete_presenter
    CompletePresenter.new(params: params, current_order: current_order)
  end

  def choose_presenter
    PRESENTERS[params[:step].to_sym].new(params: params, current_order: current_order)
  end
end
