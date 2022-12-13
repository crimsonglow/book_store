require 'rails_helper'

RSpec.describe 'Cart page', type: :feature do
  let!(:book) { create(:book) }
  let!(:coupon) { create(:coupon) }

  before do
    visit root_path
    click_link(I18n.t('home_page.buy_now'))
    visit carts_path
  end

  it 'when add book to cart' do
    expect(page).to have_css '.shop-quantity', text: '1'
    expect(page).to have_content book.title
    expect(page).to have_content book.price
  end

  it 'when delete book form cart' do
    first('.general-cart-close').click
    expect(page).to have_content I18n.t('cart.empty_cart')
  end

  it 'when click on apply coupon with empty field' do
    click_button(I18n.t('cart.apply_coupon'))
    expect(page).to have_selector 'div', text: I18n.t('cart.wrong_coupon')
  end

  it 'when click on cover book' do
    first('.thumb-hover-link').click
    expect(page).to have_current_path book_path(book)
  end

  it 'when not signed in user click on checkout button' do
    find('a', text: I18n.t('cart.checkout')).click
    expect(page).to have_current_path checkout_path(step: :quick_registrate)
  end

  it 'when use right coupon' do
    first('#coupon').set coupon.key
    click_button(I18n.t('cart.apply_coupon'))
    expect(page).to have_content I18n.t('cart.coupon_used')
  end
end
