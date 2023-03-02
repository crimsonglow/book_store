require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user_attr) { attributes_for(:user) }

  describe 'Post #create' do
    subject(:create_user) { post :create, params: params }

    before { request.env['devise.mapping'] = Devise.mappings[:user] }

    context 'when success' do
      let(:params) { { user: { email: user_attr[:email] }, checkout_signup: '' } }

      it { is_expected.to redirect_to checkout_path(step: :address) }
    end

    context 'when failure' do
      let!(:user) { create(:user) }
      let(:params) { { user: { email: user.email }, checkout_signup: '' } }

      it { is_expected.to redirect_to(new_user_password_path) }
    end
  end
end
