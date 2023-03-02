require 'rails_helper'

RSpec.describe OrderSortingService do
  let!(:user) { create(:user) }
  let!(:order1) { create(:order, :complete, user_id: user.id) }
  let!(:order2) { create(:order, :in_delivery, user_id: user.id) }
  let!(:order3) { create(:order, :delivered, user_id: user.id) }
  let!(:order4) { create(:order, :canceled, user_id: user.id) }

  describe 'orders sorting' do
    shared_examples 'returns expected result' do
      subject(:current_subject) { described_class.new(params, user) }

      it do
        expect(current_subject.call).to eq(result)
      end
    end

    context 'when by in_progress' do
      let(:params) { { sort_order_by: :in_progress } }
      let(:result) { [order1] }

      include_examples 'returns expected result'
    end

    context 'when by in_delivery' do
      let(:params) { { sort_order_by: :in_delivery } }
      let(:result) { [order2] }

      include_examples 'returns expected result'
    end

    context 'when by delivered' do
      let(:params) { { sort_order_by: :delivered } }
      let(:result) { [order3] }

      include_examples 'returns expected result'
    end

    context 'when by canceled' do
      let(:params) { { sort_order_by: :canceled } }
      let(:result) { [order4] }

      include_examples 'returns expected result'
    end

    context 'when do not sorted' do
      let(:params) { { sort_order_by: nil } }
      let(:result) { [order1] }

      include_examples 'returns expected result'
    end
  end
end
