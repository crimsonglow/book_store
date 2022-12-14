require 'rails_helper'

RSpec.describe 'Checkout address step', :js, type: :feature do
  let!(:order) { create(:order, :address_step) }
  let!(:error_empty_message) { "can't be blank" }
  let(:address) { attributes_for(:address) }
  let(:add_order_id_to_cookies) do
    Capybara.current_session.driver.browser.manage.add_cookie(name: :current_order_id, value: order.id.to_s)
  end

  before do
    login_as(order.user, scope: :user)
    visit root_path
    add_order_id_to_cookies
    click_link(I18n.t('home_page.buy_now'))
    visit carts_path
    click_link(I18n.t('cart.checkout'))
  end

  it 'when go to first step checkout' do
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'when click on continue all fields invalid' do
    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_content error_empty_message
  end

  context 'when billing' do
    let(:billing) { order.user.addresses.create(attributes_for(:address, :billing)) }

    it 'billing address exists' do
      billing
      visit checkout_path(step: :address)

      expect(page).to have_field 'billing_form[first_name]', with: billing.first_name
      expect(page).to have_field 'billing_form[last_name]', with: billing.last_name
      expect(page).to have_field 'billing_form[address]', with: billing.address
      expect(page).to have_field 'billing_form[city]', with: billing.city
      expect(page).to have_field 'billing_form[zip]', with: billing.zip
      expect(page).to have_field 'billing_form[country]', with: billing.country
      expect(page).to have_field 'billing_form[phone]', with: billing.phone
    end

    it 'when billing address exists without shipping' do
      billing
      click_on(I18n.t('checkout.save_and_continue'))
      expect(page).to have_content error_empty_message
    end
  end

  context 'when shipping' do
    let(:shipping) { order.user.addresses.create(attributes_for(:address, :shipping)) }

    it 'shipping address exists' do
      shipping
      visit checkout_path(step: :address)

      expect(page).to have_field 'shipping_form[first_name]', with: shipping.first_name
      expect(page).to have_field 'shipping_form[last_name]', with: shipping.last_name
      expect(page).to have_field 'shipping_form[address]', with: shipping.address
      expect(page).to have_field 'shipping_form[city]', with: shipping.city
      expect(page).to have_field 'shipping_form[zip]', with: shipping.zip
      expect(page).to have_field 'shipping_form[country]', with: shipping.country
      expect(page).to have_field 'shipping_form[phone]', with: shipping.phone
    end

    it 'when shipping address exists without billing' do
      shipping
      click_on(I18n.t('checkout.save_and_continue'))
      expect(page).to have_content error_empty_message
    end
  end

  it 'try to go on delivery step' do
    try_to_go_on_step_for_address('delivery_title')
  end

  it 'try to go on payment step' do
    try_to_go_on_step_for_address('payment_title')
  end

  it 'try to go on confirm step' do
    try_to_go_on_step_for_address('confirm_title')
  end

  it 'try to go on complete step' do
    try_to_go_on_step_for_address('complete_title')
  end

  it 'valid inputs' do
    fill_in_valid_input_for_address('billing_form')
    fill_in_valid_input_for_address('shipping_form')
    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_current_path checkout_path(step: :fill_delivery)
  end

  it 'when use one billing with hidden shipping' do
    find('label', class: 'checkbox-label').click
    fill_in_valid_input_for_address('billing_form')
    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_current_path checkout_path(step: :fill_delivery)
  end

  def try_to_go_on_step_for_address(step)
    find('a', class: 'step_checkout', text: I18n.t("checkout.#{step}")).click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  def fill_in_valid_input_for_address(type) # rubocop:disable Metrics/AbcSize:
    first("##{type}_first_name").set address[:first_name]
    first("##{type}_last_name").set address[:last_name]
    first("##{type}_address").set address[:address]
    first("##{type}_city").set address[:city]
    first("##{type}_zip").set address[:zip]
    first("##{type}_phone").set address[:phone]
  end
end
