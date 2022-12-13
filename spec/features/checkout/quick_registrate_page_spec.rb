require 'rails_helper'

RSpec.describe 'Quick registrate page', type: :feature do
  let!(:order) { create(:order) }
  let(:exist_user) { create(:user) }
  let(:new_user) { attributes_for(:user) }
  let(:massages) do
    {
      invalid_email: 'Invalid Email or password',
      forgot_password: 'Forgot Password',
      email_exists: 'Email exists'
    }
  end

  before do
    visit root_path
    click_link(I18n.t('home_page.buy_now'))
    visit carts_path
    click_link(I18n.t('cart.checkout'))
  end

  it 'show quick registration page' do
    expect(page).to have_current_path checkout_path(step: :quick_registrate)
  end

  it 'when click log in with empty fields' do
    click_button(I18n.t('checkout.login_with_password'))
    expect(page).to have_content massages[:invalid_email]
  end

  it 'when click log in with empty password' do
    first('#email').set exist_user.email
    first('#password').set ''
    click_button(I18n.t('checkout.login_with_password'))
    expect(page).to have_current_path new_user_session_path
  end

  it 'when click log in with empty email' do
    first('#email').set ''
    first('#password').set exist_user.password
    click_button(I18n.t('checkout.login_with_password'))
    expect(page).to have_current_path new_user_session_path
  end

  it 'when click log in with right password and email' do
    first('#email').set exist_user.email
    first('#password').set exist_user.password
    click_button(I18n.t('checkout.login_with_password'))
    expect(page).to have_selector 'a', text: I18n.t('header.my_account')
    expect(page).to have_current_path root_path
  end

  it 'when click to forgot email' do
    find('a', text: massages[:forgot_password]).click
    expect(page).to have_content massages[:forgot_password]
  end

  it 'when click to sign up with empty email' do
    first('.btn-submit-login-sign-up').click
    expect(page).to have_current_path user_session_path
  end

  it 'when click on sign up with exists email' do
    all('#email').last.set exist_user.email
    click_on(I18n.t('checkout.sign_up'))
    expect(page).to have_content massages[:email_exists]
  end

  it 'when click on sign up with right email' do
    all('#email').last.set new_user[:email]
    click_on(I18n.t('checkout.sign_up'))
    expect(page).to have_selector 'a', text: I18n.t('header.my_account')
  end
end
