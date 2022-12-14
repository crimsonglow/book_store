require 'rails_helper'

RSpec.describe 'Payment card page', :js, type: :feature do
  let(:delivery) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :payment_step, delivery_id: delivery.id) }
  let(:error_empty_message) { "can't be blank" }
  let(:credit_card_attr) { attributes_for(:credit_card) }
  let(:add_order_id_to_cookies) do
    Capybara.current_session.driver.browser.manage.add_cookie(name: :current_order_id, value: order.id.to_s)
  end

  before do
    visit root_path
    add_order_id_to_cookies
    login_as(order.user, scope: :user)
    visit checkout_path(step: :payment)
  end

  it 'when go to payment step' do
    expect(page).to have_current_path checkout_path(step: :payment)
  end

  it 'when all fields invalid' do
    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_content error_empty_message
  end

  it 'try to go on delivery step' do
    try_to_go_on_step_for_payment('address_title', :address)
  end

  it 'try to go on delivery step' do
    try_to_go_on_step_for_payment('delivery_title', :fill_delivery)
  end

  it 'try to go on confirm step' do
    try_to_go_on_step_for_payment('confirm_title', :payment)
  end

  it 'try to go on complete step' do
    try_to_go_on_step_for_payment('complete_title', :payment)
  end

  it 'go to next step with valid fields' do
    fill_in_valid_input_for_payment

    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_current_path checkout_path(step: :confirm)
  end
end

def fill_in_valid_input_for_payment
  fill_in 'credit_card_form[number]', with: credit_card_attr[:number]
  fill_in 'credit_card_form[name]', with: credit_card_attr[:name]
  fill_in 'credit_card_form[date]', with: credit_card_attr[:date]
  fill_in 'credit_card_form[cvv]', with: credit_card_attr[:cvv]
end

def try_to_go_on_step_for_payment(choice, step)
  find('a', class: 'step_checkout', text: I18n.t("checkout.#{choice}")).click
  expect(page).to have_current_path checkout_path(step: step)
end
