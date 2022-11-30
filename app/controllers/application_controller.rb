class ApplicationController < ActionController::Base
  before_action :header_presenter

  include Pundit::Authorization

  def header_presenter
    @header_presenter = HeaderPresenter.new(current_order: current_order)
  end

  def current_order
    Order.find_by(id: cookies[:current_order_id])
  end
end
