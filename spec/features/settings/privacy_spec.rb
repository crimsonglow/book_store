require 'rails_helper'

RSpec.describe 'Settings privacy page', type: :feature do
  let!(:user) { create(:user) }
  let(:user_attributes) { attributes_for(:user) }

  before do
    login_as(user, scope: :user)
    visit new_setting_path
  end

  context 'when change email' do
    let(:new_email) { user_attributes[:email] }
    let(:error_message_email) { "Email can't be blank and Email is invalid" }
    let(:success_message_email) { I18n.t('controllers.updated_email') }

    it 'when click on submit with empty field' do
      change_email('')
      expect(page).to have_content error_message_email
    end

    it 'when successfuly change email' do
      change_email(new_email)
      expect(page).to have_content success_message_email
    end
  end

  context 'when change password' do
    let(:new_password) { user_attributes[:password] }
    let(:error_message_password) { I18n.t('controllers.wrong_password') }
    let(:successfuly_update_password_messave) { I18n.t('controllers.changed_password') }

    it 'click on submit with empty field' do
      change_password('', '', '')
      expect(page).to have_content error_message_password
    end

    it 'click on submit with wrong old password' do
      change_password(new_password, new_password, new_password)
      expect(page).to have_content error_message_password
    end

    it 'click on submit with wrong new password' do
      change_password(user.password, user.password, new_password)
      expect(page).to have_content error_message_password
    end

    it 'click on submit with wrong confirm password' do
      change_password(user.password, new_password, '')
      expect(page).to have_content error_message_password
    end

    it 'click on submit with all valid fields' do
      change_password(user.password, new_password, new_password)
      expect(page).to have_content successfuly_update_password_messave
    end
  end

  context 'delete account' do
    let(:remove_account_message) { I18n.t('settings.account_deleted') }

    it 'click on remove account' do
      remove_account
      expect(page).to have_content remove_account_message
    end
  end
end

def change_email(email)
  fill_in 'email', with: email.to_s
  all('input[type=submit]')[4].click
end

def change_password(old_password, new_password, confirm_password)
  fill_in 'old_password', with: old_password.to_s
  fill_in 'new_password', with: new_password.to_s
  fill_in 'confirm_password', with: confirm_password.to_s
  all('input[type=submit]')[5].click
end

def remove_account
  find('span', class: 'checkbox-icon').click
  click_on(I18n.t('settings.remove_account_submit'))
end
