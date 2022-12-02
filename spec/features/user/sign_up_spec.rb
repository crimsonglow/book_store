require 'rails_helper'

describe 'Sign up page', type: :feature do
  let(:empty_field) { "can't be blank" }
  let(:error_wrong_confirm_password) { "doesn't match Password" }
  let(:user) { attributes_for(:user) }
  let(:success_message) { 'A message with a confirmation link has been sent to your email address.' }

  before { visit(new_user_registration_path) }

  describe 'when wrong attempts' do
    shared_examples 'returns expected result' do
      before { fill_in_data_and_click_button(email, password, password_confirmation) }

      it { expect(page).to have_content(empty_field) }
    end

    context 'when click with no data' do
      let(:email) { '' }
      let(:password)  { '' }
      let(:password_confirmation) {  }

      include_examples 'returns expected result'
    end

    context 'when click no password data' do
      let(:email) { user[:email] }
      let(:password)  { '' }
      let(:password_confirmation) { user[:password] }

      include_examples 'returns expected result'
    end

    context 'when click no email data' do
      let(:email) { '' }
      let(:password) { user[:password] }
      let(:password_confirmation) { user[:password] }

      include_examples 'returns expected result'
    end

    context 'when click no password confirmation data' do
      let(:email) { user[:email] }
      let(:password) { user[:password] }
      let(:password_confirmation) { '' }

      before { fill_in_data_and_click_button(email, password, password_confirmation) }

      it { expect(page).to have_content(error_wrong_confirm_password) }
    end
  end

  context 'when all fields right' do
    let(:email) { user[:email] }
    let(:password)  { user[:password] }
    let(:password_confirmation) { user[:password] }

    before { fill_in_data_and_click_button(email, password, password_confirmation) }

    it { expect(page).to have_content(success_message) }
  end

  it 'goes to log in' do
    find('a', text: 'Log In').click
    expect(page).to have_content('Remember me')
  end

private

  def fill_in_data_and_click_button(email, password, password_confirmation)
    fill_in 'user[email]', with: "#{email}"
    fill_in 'user[password]', with: "#{password}"
    fill_in 'user[password_confirmation]', with: "#{password_confirmation}"

    click_button(I18n.t('devise_custom.back_to_store'))
  end
end
