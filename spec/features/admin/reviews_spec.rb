require 'rails_helper'

RSpec.describe 'Admin reviews page', type: :feature do
  let!(:review) { create(:review) }

  login_admin

  context 'when visit reviews page' do
    before { visit 'admin/book_reviews' }

    it { expect(page).to have_content review.title }
    it { expect(page).to have_content 'Book Reviews' }
  end
end
