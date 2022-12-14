require 'rails_helper'

RSpec.describe AddressCheckoutService do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:billing_attr) { attributes_for(:address, :billing, order_id: order.id) }
  let(:shipping_attr) { attributes_for(:address, :shipping, order_id: order.id) }

  describe 'create checkout addresses ' do
    subject(:current_subject) { described_class.new(params, user, order) }

    context 'when success' do
      let(:params) { { billing_form: billing_attr, shipping_form: shipping_attr } }

      before { current_subject.call }

      it { expect(Address.shipping).not_to be_empty }
      it { expect(Address.billing).not_to be_empty }

      it 'valid new address' do
        params[:billing_form].delete(:order_id)
        params[:shipping_form].delete(:order_id)
        expect(Address.billing.first).to have_attributes(params[:billing_form])
        expect(Address.shipping.first).to have_attributes(params[:shipping_form])
      end
    end

    context 'when failure' do
      let(:params) { { billing_form: {}, shipping_form: {} } }

      it 'invalid new address' do
        expect(current_subject.call).to eq(nil)
        expect(order.addresses).to eq([])
      end
    end
  end

  describe 'create checkout addresses with hidden shipping form' do
    subject(:current_subject) { described_class.new(params, user, order) }

    context 'when success' do
      let(:params) { { billing_form: billing_attr, hidden_shipping_form: true } }

      it 'valid new address' do
        expect { current_subject.call }.to change(Address, :count).from(0).to(2)
      end
    end

    context 'when failure' do
      let(:params) { { billing_form: {}, hidden_shipping_form: true } }

      it 'valid new address' do
        expect(current_subject.call).to eq(nil)
        expect(order.addresses).to eq([])
      end
    end
  end
end
