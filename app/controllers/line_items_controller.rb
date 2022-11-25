class LineItemsController < ApplicationController
  rescue_from(CartCreateService::UnsupportedFormFields) do
    redirect_message('Form fields are unsupported', :error)
  end

  def create
    result = CartCreateService.call(create_params, current_order)
    cookies[:current_order_id] = result[:order_id] unless current_order
    redirect_message(I18n.t('controllers.added_in_cart'), :success)
  end

  def update
    CartUpdateService.call(params)
    redirect_to(carts_path)
  end

  def destroy
    service = CartDeleteService.call(current_order, params)
    cookies.delete(:current_order_id) if service[:delete_order?]
    redirect_message(I18n.t('controllers.deleted_from_cart'), :success)
  end

  private

  def redirect_message(message, type)
    redirect_back(fallback_location: root_path)
    flash[type] = message
  end

  def create_params
    params.require(:line_item).permit(:current_book)
  end
end
