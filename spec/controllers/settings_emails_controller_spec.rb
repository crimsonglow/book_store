require 'rails_helper'

RSpec.describe SettingsEmailsController, type: :controller do
  let(:user) { attributes_for(:user) }
  let(:current_user_id) { User.first.id }

  login_user

  describe 'PUT #update' do
    subject(:update_settings_emails) { put :update, params: params }

    context 'when success' do
      let(:params) { { email: user[:email], user_id: current_user_id, id: current_user_id } }

      it 'sets flash message' do
        update_settings_emails
        expect(flash[:success]).to be_present
      end

      it { is_expected.to redirect_to(new_setting_path) }
    end

    context 'when failure' do
      let(:params) { { email: '', user_id: current_user_id, id: current_user_id } }

      it 'sets flash message' do
        update_settings_emails
        expect(flash[:error]).to be_present
      end

      it { is_expected.to redirect_to(new_setting_path) }
    end
  end
end
