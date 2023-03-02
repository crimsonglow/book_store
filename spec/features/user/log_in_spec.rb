require 'rails_helper'

describe 'Log in', type: :feature do
  let!(:user) { create(:user) }
  let(:error_massage) { 'Invalid Email or password.' }
  let(:success_massage) { 'Signed in successfully.' }

  before { visit(new_user_session_path) }

  describe 'when wrong attempts' do
    shared_examples 'returns expected result' do
      before { fill_in_data_and_click_button(email, password) }

      it { expect(page).to have_content(error_massage) }
    end

    context 'when click with no data' do
      let(:email) { '' }
      let(:password) { '' }

      include_examples 'returns expected result'
    end

    context 'when click no password data' do
      let(:email) { user.email }
      let(:password) { '' }

      include_examples 'returns expected result'
    end

    context 'when click no email data' do
      let(:email) { '' }
      let(:password) { user.password }

      include_examples 'returns expected result'
    end
  end

  context 'when data is correct' do
    let(:email) { user.email }
    let(:password) { user.password }

    before { fill_in_data_and_click_button(email, password) }

    it { expect(page).to have_current_path root_path }
    it { expect(page).to have_content(success_massage) }
  end

  it 'goes to forgot password' do
    find('a', text: 'Forgot Password').click
    expect(page).to have_content('Email Instruction')
  end

  it 'goes to sign up' do
    find('a', text: 'Sign Up').click
    expect(page).to have_content('Confirm Password')
  end

  private

  def fill_in_data_and_click_button(email, password)
    fill_in 'user[email]', with: email.to_s
    fill_in 'user[password]', with: password.to_s

    click_button(I18n.t('devise_custom.back_to_store'))
  end
end
