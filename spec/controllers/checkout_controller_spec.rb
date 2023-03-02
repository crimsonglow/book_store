require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }

  before do
    sign_in user
    cookies[:current_order_id] = order.id
  end

  describe 'GET #show' do
    before { get :show, params: { step: :address } }

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'PUT #update' do
    subject(:update_checkout) { put :update, params: params }

    before do
      order.address!
      order.fill_delivery!
    end

    context 'when success' do
      let!(:delivery) { create(:delivery) }
      let(:params) { { step: :fill_delivery, delivery_id: delivery.id } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(update_checkout).to redirect_to checkout_path(step: :payment) }
    end

    context 'when failure' do
      let(:params) { { step: :payment, delivery_id: '' } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(update_checkout).to render_template(:show) }
    end
  end
end
