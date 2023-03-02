require 'rails_helper'

RSpec.describe 'Admin author page', type: :feature do
  let!(:author) { create(:author) }

  login_admin

  context 'when visit author page' do
    before { visit 'admin/authors' }

    it { expect(page).to have_content author.description }
    it { expect(page).to have_content 'Authors' }
  end
end
