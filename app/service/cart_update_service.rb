class CartUpdateService
  private_class_method :new

  ONE_ITEM = 1

  def self.call(params)
    new(params).call
  end

  def call
    { success: update_column }
  end

  private

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def line_item
    @line_item ||= LineItem.find_by(id: params[:id])
  end

  def change_quantity_item
    @change_quantity_item ||= params[:plus] ? line_item.quantity += ONE_ITEM : line_item.quantity -= ONE_ITEM
  end

  def update_column
    return false unless validate_quantity!

    line_item.update_column(:quantity, change_quantity_item)
  end

  def validate_quantity!
    change_quantity_item.positive?
  end
end
