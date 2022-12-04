require 'rails_helper'

RSpec.describe AddressSettingsService do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  describe 'settings address success' do
    subject(:current_subject) { described_class.new(billing_address, user, order) }

    let(:billing_address) { { billing_form: attributes_for(:address, :billing, user_id: user.id) } }
    let(:billing_address_update) { { billing_form: attributes_for(:address, :billing, zip: 9876, user_id: user.id) } }

    before { current_subject.call }

    context 'when crates' do
      it { expect(user.addresses.first).to be_truthy }
    end

    context 'when updates' do
      subject(:update_current_subject) { described_class.new(billing_address_update, user, order) }

      before { update_current_subject.call }

      it { expect(user.addresses.first.zip).to eq(billing_address_update[:billing_form][:zip]) }
    end
  end

  describe 'incorrect data' do
    subject(:current_subject) { described_class.new(billing_address_error, user, order) }

    let(:billing_address_error) { { billing_form: attributes_for(:address, :billing, zip: '', user_id: user.id) } }

    it { expect(current_subject.call).to be_nil }
    it { expect(user.addresses).to eq([]) }
  end
end
