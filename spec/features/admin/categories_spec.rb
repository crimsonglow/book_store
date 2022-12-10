require 'rails_helper'

RSpec.describe 'Admin category page', type: :feature do
  let!(:category) { create(:category) }

  login_admin

  context 'when visit category page' do
    before { visit 'admin/categories' }

    it { expect(page).to have_content category.name }
    it { expect(page).to have_content 'Categories' }
  end
end
