require 'rails_helper'

describe 'Books page', type: :feature do
  let(:category) { FactoryBot.create(:category, name: 'Photo') }
  let!(:book) { FactoryBot.create(:book) }
  let!(:book_photo) { FactoryBot.create(:book, category: category, price: rand(100...990.99).round(2)) }

  before { visit(books_path) }

  it 'loads books page' do
    expect(page).to have_content(book.title)
    expect(page).to have_content(book_photo.title)
    page.status_code == 200
  end

  it 'loads category' do
    find('a', class: 'filter-link', text: category.name).click
    expect(page).not_to have_content(book.title)
    expect(page).to have_content(book_photo.title)
  end

  it 'adds book to cart' do
    click_link(href: line_items_path(line_item: { current_book: book.id }))

    expect(LineItem.last.book_id).to eq(book.id)
  end

  it 'goes to book page' do
    find('a', class: 'thumb-hover-link', match: :first).click
    expect(page).to have_current_path book_path(book_photo.id)
  end
end
