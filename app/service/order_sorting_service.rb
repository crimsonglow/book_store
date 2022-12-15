class OrderSortingService
  attr_reader :params, :current_user

  SORT_BY = {
    in_progress: ->(instance) { instance.order_by('complete') },
    in_delivery: ->(instance) { instance.order_by('in_delivery') },
    delivered: ->(instance) { instance.order_by('delivered') },
    canceled: ->(instance) { instance.order_by('canceled') }
  }.freeze

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    params[:sort_order_by] = :in_progress unless SORT_BY.include?(params[:sort_order_by]&.to_sym)

    SORT_BY[params[:sort_order_by].to_sym].call(self)
  end

  def order_by(by)
    order = Order.where(user_id: current_user.id, status: by).includes([:coupon, :delivery])
    OrderDecorator.decorate_collection(order)
  end
end
