require 'rails_helper'

RSpec.describe CartDeleteService do
  subject(:current_subject) { described_class.call(params, current_order) }

  let!(:current_order) { create(:order) }

  context 'when delete success' do
    let(:params) { { id: current_order.line_items.first.book.id } }

    it { expect(current_subject[:success]).to be_an_instance_of(LineItem) }
    it { expect(current_subject[:delete_order?]).to be_an_instance_of(Order) }
  end
end
