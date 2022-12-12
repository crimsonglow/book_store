require 'rails_helper'

RSpec.describe 'Admin book images page', type: :feature do
  let!(:book) { create(:book) }
  let!(:img) { create(:book_image, book_id: book.id) }

  login_admin

  context 'when visit book images page' do
    before { visit 'admin/book_images' }

    it { expect(page).to have_content book.title }
    it { expect(page).to have_content 'Book Images' }
  end
end
