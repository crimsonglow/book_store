require 'rails_helper'

RSpec.describe 'Checkout delivery step', :js, type: :feature do
  let!(:delivery) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :fill_delivery_step, delivery_id: delivery.id) }
  let(:add_order_id_to_cookies) do
    Capybara.current_session.driver.browser.manage.add_cookie(name: :current_order_id, value: order.id.to_s)
  end

  before do
    visit root_path
    add_order_id_to_cookies
    login_as(order.user, scope: :user)
    visit checkout_path(step: :fill_delivery)
  end

  it 'go to step delivery' do
    expect(page).to have_current_path checkout_path(step: :fill_delivery)
  end

  it 'try to go on address step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.address_title')).click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'try to go on payment step' do
    try_to_go_on_step_for_delivery('payment_title')
  end

  it 'try to go on confirm step' do
    try_to_go_on_step_for_delivery('confirm_title')
  end

  it 'try to go on complete step' do
    try_to_go_on_step_for_delivery('complete_title')
  end

  it 'click submit with checked delivery method' do
    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_current_path checkout_path(step: :payment)
  end
end

def try_to_go_on_step_for_delivery(step)
  find('a', class: 'step_checkout', text: I18n.t("checkout.#{step}")).click
  expect(page).to have_current_path checkout_path(step: :fill_delivery)
end
