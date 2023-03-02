require 'rails_helper'

describe 'Book page', type: :feature do
  let!(:book) { FactoryBot.create(:book) }

  before { visit(book_path(book.id)) }

  it { expect(page).to have_content(book.title) }

  it 'adds book to cart' do
    click_on('Add to Cart')

    expect(LineItem.last.book_id).to eq(book.id)
  end
end
