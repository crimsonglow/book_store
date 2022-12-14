require 'rails_helper'

RSpec.describe CheckoutShowService do
  subject(:current_subject) { described_class.new(params, order, user) }

  let(:user) { create(:user) }
  let(:order) { create(:order) }
  let(:params) { {} }

  context 'when the user is not present' do
    before { allow(current_subject).to receive(:current_user).and_return(nil) }

    it { expect(current_subject.current_presenter).to be_an_instance_of(QuickRegistrationPresenter) }
  end

  context 'when the status of the order cart' do
    before { current_subject.current_presenter }

    it { expect(Order.last.status).to eq('address') }
    it { expect(Order.last.user_id).to eq(user.id) }
  end

  context 'when the order status is delivery' do
    let(:params) { { step: :fill_delivery } }
    let(:order) { create(:order, user_id: user.id) }

    before do
      order.address!
      order.fill_delivery!
      current_subject.current_presenter
    end

    it { expect(current_subject.current_presenter).to be_an_instance_of(DeliveryPresenter) }
  end
end
