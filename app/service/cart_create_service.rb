class CartCreateService
  class UnsupportedFormFields < StandardError; end

  COUNT_BOOKS = 1

  private_class_method :new

  def self.call(create_params, current_order)
    new(create_params, current_order).call
  end

  def call
    validate_form_fields!
    { success: save_book, order_id: order.id }
  end

  private

  attr_reader :create_params, :current_order

  def initialize(create_params, current_order)
    @create_params = create_params
    @current_order = current_order
  end

  def save_book
    update_book_quantity || create_book
  end

  def cart_form
    @cart_form ||= CartForm.new(create_params)
  end

  def validate_form_fields!
    return if cart_form.valid?

    raise UnsupportedFormFields
  end

  def order
    @order ||= current_order || Order.create
  end

  def books
    @books ||= order.line_items
  end

  def current_book
    @current_book ||= books.find_by(book_id: cart_form.current_book)
  end

  def create_book
    books.create(book_id: cart_form.current_book, quantity: COUNT_BOOKS)
  end

  def update_book_quantity
    return unless current_book

    current_book.quantity += COUNT_BOOKS
    current_book.save
  end
end
