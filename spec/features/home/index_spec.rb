require 'rails_helper'

RSpec.describe 'Home page', type: :feature do
  let!(:book) { FactoryBot.create(:book) }

  before { visit(root_path) }

  it 'loads home page' do
    expect(page).to have_content(I18n.t('home_page.welcome'))
  end

  it 'goes to book by click title book' do
    click_link(book.title)

    expect(page).to have_current_path book_path(book.id)
  end

  it 'adds book to cart' do
    click_link(I18n.t('home_page.buy_now'))

    expect(LineItem.last.book_id).to eq(book.id)
  end

  it 'goes to category by click link Get Started' do
    click_link(I18n.t('home_page.get_started'))

    expect(page).to have_current_path books_path
  end
end
