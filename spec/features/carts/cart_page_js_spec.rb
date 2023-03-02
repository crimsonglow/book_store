require 'rails_helper'

RSpec.describe 'Cart page with elements of js', :js, type: :feature do
  let!(:book) { create(:book) }

  before do
    visit root_path
    click_link(I18n.t('home_page.buy_now'))
    visit carts_path
  end

  context 'when increment and decrement quantity book' do
    let(:quantity_books_after_increment) { '2' }
    let(:quantity_books_after_decrement) { '1' }

    before do
      find('.fa-plus', match: :first).click
    end

    it 'when increment quantity book' do
      expect(page).to have_css '.shop-quantity', text: quantity_books_after_increment
      expect(first('.quantity-input').value).to eq quantity_books_after_increment
    end

    it 'when decrement quantity book' do
      find('.fa-minus', match: :first).click
      expect(page).to have_css '.shop-quantity', text: quantity_books_after_decrement
      expect(first('.quantity-input').value).to eq quantity_books_after_decrement
    end
  end
end
