require 'rails_helper'

RSpec.describe PaymentService do
  subject(:current_subject) { described_class.new(params, user, order) }

  let(:user) { create(:user) }
  let!(:order) { create(:order) }
  let(:credit_card) { attributes_for(:credit_card, order_id: order.id) }

  context 'when card success' do
    let(:params) { { credit_card_form: credit_card } }

    it { expect(current_subject.call).to be_truthy }
  end

  context 'when card failed' do
    let(:params) { { credit_card_form: {} } }

    it 'when card not create' do
      expect(current_subject.call).to eq(nil)
      expect(CreditCard.all).to eq([])
    end
  end

  context 'when update card' do
    let!(:create_credit_card) { create(:credit_card, order_id: order.id, cvv: 421) }
    let(:params) { { credit_card_form: credit_card } }

    before { current_subject.call }

    it { expect(CreditCard.last.cvv).to eq(credit_card[:cvv]) }
  end
end
