require 'rails_helper'

RSpec.describe 'Admin home page', type: :feature do
  let(:successful_message) { { flesh: 'Signed in successfully.', title: 'Dashboard' } }
  login_admin

  context 'when visit home page' do
    it { expect(page).to have_content successful_message[:flesh] }
    it { expect(page).to have_content successful_message[:title] }
  end
end
