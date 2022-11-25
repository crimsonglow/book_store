class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(key: params[:coupon])

    unless coupon.order_id
      coupon.update(order_id: current_order.id)
    else
      flash[:error] = I18n.t('controllers.wrong_coupon')
    end

    redirect_to(carts_path)
  end
end
