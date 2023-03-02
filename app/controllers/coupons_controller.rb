class CouponsController < ApplicationController
  def update
    @coupon = Coupon.find_by(key: params[:coupon])

    if validate?
      @coupon.update(order_id: params[:id])
    else
      flash[:error] = I18n.t('controllers.wrong_coupon')
    end

    redirect_to(carts_path)
  end

  private

  def validate?
    return unless @coupon

    @coupon.order_id.nil?
  end
end
