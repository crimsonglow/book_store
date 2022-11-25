class CartDeleteService
  private_class_method :new

  def self.call(current_order, params)
    new(current_order, params).call
  end

  def call
    { success: delete_item, delete_order?: delete_order }
  end

  private

  attr_reader :current_order, :params

  def initialize(current_order, params)
    @current_order = current_order
    @params = params
  end

  def delete_order
    [delete_coupon_from_order, current_order.destroy] if empty_order?
  end

  def delete_item
    current_order.line_items.find_by(book_id: params[:id]).delete
  end

  def delete_coupon_from_order
    current_order.coupon&.update(order_id: nil)
  end

  def empty_order?
    current_order.line_items.empty?
  end
end
