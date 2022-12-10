require 'rails_helper'

RSpec.describe 'Admin reviews page', type: :feature do
  let!(:author) { create(:author) }

  login_admin

  context 'when visit authors page' do
    before { visit 'admin/authors' }

    it { expect(page).to have_content author.description }
    it { expect(page).to have_content 'Authors' }
  end
end
