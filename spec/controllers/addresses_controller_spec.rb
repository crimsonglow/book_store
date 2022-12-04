require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }
  let(:billing_address) { { billing_form: attributes_for(:address, :billing, user_id: user.id) } }
  let(:billing_address_error) { { billing_form: attributes_for(:address, :billing, zip: '', user_id: user.id) } }

  describe 'POST #create' do
    before { sign_in(user) }

    context 'when  a successful' do
      before { post :create, params: billing_address }

      it { is_expected.to redirect_to(new_setting_path) }
    end

    context 'when unsuccessfully' do
      before { post :create, params: billing_address_error }

      it { is_expected.to render_template('settings/new') }
    end
  end
end
