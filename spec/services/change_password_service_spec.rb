require 'rails_helper'

RSpec.describe ChangePasswordService do
  subject(:current_subject) { described_class.call(user, params) }

  let(:user) { create(:user) }
  let(:custom_password) { attributes_for(:user, password: 'passwordAa1') }

  shared_examples 'returns expected result' do
    before { current_subject }

    it { is_expected.to eq(result) }
  end

  context 'when success' do
    let(:params) do
      { id: user.id, old_password: user.password, new_password: custom_password[:password],
        confirm_password: custom_password[:password] }
    end
    let(:result) { { success: true } }

    include_examples 'returns expected result'
  end

  context 'when not the right old_password' do
    let(:params) do
      { id: user.id, old_password: custom_password[:password], new_password: custom_password[:password],
        confirm_password: custom_password[:password] }
    end
    let(:result) { { success: false } }

    include_examples 'returns expected result'
  end

  context 'when not the right confirm_password' do
    let(:params) do
      { id: user.id, old_password: user.password, new_password: user.password,
        confirm_password: custom_password[:password] }
    end
    let(:result) { { success: false } }

    include_examples 'returns expected result'
  end

  context 'when the old password and the new password are the same' do
    let(:params) do
      { id: user.id, old_password: user.password, new_password: custom_password[:password], confirm_password: '' }
    end
    let(:result) { { success: false } }

    include_examples 'returns expected result'
  end
end
