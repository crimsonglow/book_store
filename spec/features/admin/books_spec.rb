require 'rails_helper'

RSpec.describe 'Admin reviews page', type: :feature do
  let!(:book) { create(:book) }

  login_admin

  context 'when visit reviews page' do
    before { visit 'admin/books' }

    it { expect(page).to have_content book.title }
    it { expect(page).to have_content 'Books' }
  end
end
