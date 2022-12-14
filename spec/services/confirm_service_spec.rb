require 'rails_helper'

RSpec.describe ConfirmService do
  subject(:current_subject) { described_class.new(params, user, order) }

  let(:user) { create(:user) }
  let(:order) { create(:order, :payment_step) }
  let(:params) { { user_id: user.id } }

  context 'when confirm success' do
    it do
      expect(current_subject.call).to eq(true)
      expect(order.number).not_to eq(nil)
    end
  end

  context 'when confirm failed' do
    before { allow(current_subject).to receive(:current_order).and_return(nil) }

    it do
      expect(current_subject.call).to eq(nil)
      expect(order.status).to eq('payment')
    end
  end
end
