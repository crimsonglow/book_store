require 'rails_helper'

RSpec.describe AddressSettingsService do
  let(:current_subject) { described_class.new(params, user, order) }
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  before { current_subject.call }

  describe 'settings address success' do
    let(:params) { { billing_form: attributes_for(:address, :billing, user_id: user.id) } }

    context 'when crates' do
      it { expect(user.addresses.first).to be_truthy }
    end

    context 'when updates' do
      let(:params) { { billing_form: attributes_for(:address, :billing, zip: 9876, user_id: user.id) } }

      before { current_subject.call }

      it { expect(user.addresses.first.zip).to eq(params[:billing_form][:zip]) }
    end
  end

  describe 'incorrect data' do
    let(:params) { { billing_form: attributes_for(:address, :billing, zip: '', user_id: user.id) } }

    it { expect(current_subject.call).to be_nil }
    it { expect(user.addresses).to eq([]) }
  end
end
