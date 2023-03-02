require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let!(:order) { create(:order) }
  let!(:coupon) { create(:coupon) }

  describe 'PUT #update' do
    subject(:update_coupon) { put :update, params: params }

    context 'when success' do
      let(:params) { { coupon: coupon.key, id: order.id } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(update_coupon).to redirect_to carts_path }
    end

    context 'when failure' do
      let(:params) { { coupon: '', id: order.id } }

      it 'sets flash message' do
        update_coupon
        expect(flash[:error]).to be_present
      end

      it { expect(update_coupon).to redirect_to carts_path }
    end
  end
end
