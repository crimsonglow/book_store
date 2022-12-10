class AccountsController < ApplicationController
  def destroy
    if current_user&.destroy
      cookies.delete(:current_order_id)
      flash[:success] = I18n.t('controllers.deleted_account')
    else
      flash[:error] = I18n.t('controllers.error_deleted_account')
    end
    redirect_to root_path
  end

  def update
    change_password = ChangePasswordService.call(current_user, params)
    if change_password[:success]
      flash[:success] = I18n.t('controllers.changed_password')
    else
      flash[:error] = I18n.t('controllers.wrong_password')
    end
    bypass_sign_in(current_user)
    redirect_to new_setting_path
  end
end
