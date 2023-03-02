class CartDeleteService
  private_class_method :new

  def self.call(params, current_order)
    new(params, current_order).call
  end

  def call
    { success: delete_item, delete_order?: delete_order }
  end

  private

  attr_reader :current_order, :params

  def initialize(params, current_order)
    @params = params
    @current_order = current_order
  end

  def delete_order
    current_order.destroy if empty_order?
  end

  def delete_item
    current_order.line_items.find_by(book_id: params[:id]).delete
  end

  def empty_order?
    current_order.line_items.empty?
  end
end
