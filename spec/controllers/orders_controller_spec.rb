require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:order) { create(:order, :complete_step) }

  describe 'GET #index' do
    login_user
    it do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    login_user
    it do
      get :show, params: { id: order.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
