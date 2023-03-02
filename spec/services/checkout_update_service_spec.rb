require 'rails_helper'

RSpec.describe CheckoutUpdateService do
  let(:user) { create(:user) }
  let(:order) { create(:order, :fill_delivery_step, user_id: user.id) }

  describe 'delivery checkout service' do
    subject(:current_subject) { described_class.new(params, order, user) }

    let!(:delivery) { create(:delivery) }

    context 'when success' do
      let(:params) { { step: 'fill_delivery', delivery_id: delivery.id } }

      it { expect(current_subject.call).to be_truthy }
    end

    context 'when failure' do
      let(:params) { { step: 'payment', delivery_id: '' } }

      it { expect(current_subject.call).to be_falsey }
    end

    context 'when the next step ' do
      let(:params) { { step: 'fill_delivery', delivery_id: delivery.id } }

      before { current_subject.go_to_next_step }

      it { expect(Order.last.status).to eq('payment') }
    end
  end
end
