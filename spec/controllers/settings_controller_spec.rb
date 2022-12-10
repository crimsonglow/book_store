require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  describe 'GET #new' do
    login_user
    before { get(:new) }

    it { is_expected.to respond_with(200) }
  end
end
