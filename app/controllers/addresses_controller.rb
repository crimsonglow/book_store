class AddressesController < ApplicationController
  before_action :authenticate_user!

  def create
    address_service = AddressSettingsService.new(params.permit!, current_user, current_order)
    return redirect_to(new_setting_path) if address_service.call

    @presenter = address_service.presenter
    render 'settings/new'
  end
end
