require 'rails_helper'

RSpec.describe DeliveryService do
  subject(:current_subject) { described_class.new(params, user, order) }

  let(:user) { create(:user) }
  let(:delivery) { create(:delivery) }
  let(:order) { create(:order) }
  let(:params) { { step: 'delivery', delivery_id: delivery.id } }

  context 'when success' do
    it { expect(current_subject.call).to be_truthy }
  end

  context 'when failure' do
    before { allow(current_subject).to receive(:current_order).and_return(nil) }

    it { expect(current_subject.call).to be_falsey }
  end
end
