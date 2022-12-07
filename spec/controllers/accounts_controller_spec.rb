require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'DELETE #destroy' do
    subject(:delete_user) { delete :destroy, params: params }

    let(:user) { User.first }

    login_user

    context 'when success' do
      let(:params) { { id: user.id } }

      before { delete_user }

      it { expect(flash[:success]).to be_present }
      it { expect(User.all).to be_empty }
      it { is_expected.to redirect_to root_path }
    end

    context 'when failure' do
      let(:params) { { id: '' } }

      before do
        User.last.update(id: user.id + 1)
        delete_user
      end

      it { expect(flash[:error]).to be_present }
      it { is_expected.to redirect_to root_path }
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:custom_password) { attributes_for(:user, password: 'passwordAs1') }
    let(:update_password) { put :update, params: params }

    shared_examples 'returns expected result' do
      before do
        sign_in user
        update_password
      end

      it { expect(flash[flash_type]).to be_present }
      it { is_expected.to redirect_to new_setting_path }
    end

    context 'when success' do
      let(:params) do
        { id: user.id, old_password: user.password, new_password: custom_password[:password],
          confirm_password: custom_password[:password] }
      end
      let(:flash_type) { :success }

      include_examples 'returns expected result'
    end

    context 'when not the right old_password' do
      let(:params) { { id: user.id, old_password: user.password, new_password: '', confirm_password: '' } }
      let(:flash_type) { :error }

      include_examples 'returns expected result'
    end
  end
end
