require 'rails_helper'

RSpec.describe CartUpdateService do
  subject(:current_subject) { described_class.call(params) }

  let(:current_user) { create(:user) }
  let(:order) { create(:order) }

  shared_examples 'returns expected result' do
    before { current_subject }

    it { is_expected.to eq(result) }
  end

  context 'when update success' do
    let(:params) { { plus: true, id: order.line_items.first.id } }
    let(:result) { { success: true } }

    include_examples 'returns expected result'
  end

  context 'when the quantity is less than 1' do
    let(:params) { { minus: true, id: order.line_items.first.id } }
    let(:result) { { success: false } }

    include_examples 'returns expected result'
  end
end
