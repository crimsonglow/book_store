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
    return SORT_BY[:in_progress].call(self) unless params[:sort_order_by]

    SORT_BY[params[:sort_order_by].to_sym].call(self)
  end

  def order_by(by)
    OrderDecorator.decorate_collection(Order.where(user_id: current_user.id, status: by))
  end
end
