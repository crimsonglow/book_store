require 'rails_helper'

RSpec.describe CartCreateService do
  subject(:current_subject) { described_class.call(params, order) }

  let(:order) { create(:order) }
  let(:book) { create(:book) }

  context 'when create success' do
    let(:params) { { current_book: book.id } }

    before { current_subject }

    it { expect(current_subject[:order_id]).to eq(order.id) }
    it { expect(current_subject[:success]).to be_an_instance_of(LineItem) }
  end

  context 'when create failed' do
    let(:params) { { current_book: '' } }

    it { expect { current_subject }.to raise_error(CartCreateService::UnsupportedFormFields) }
  end
end
