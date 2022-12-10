require 'rails_helper'

RSpec.describe 'Admin reviews page', type: :feature do
  let!(:category) { create(:category) }

  login_admin

  context 'when visit reviews page' do
    before { visit 'admin/categories' }

    it { expect(page).to have_content category.name }
    it { expect(page).to have_content 'Categories' }
  end
end
