require 'rails_helper'

RSpec.describe 'Settings page', type: :feature do
  let!(:user) { create(:user) }
  let(:error_message) { "can't be blank, Must write without special symbols" }
  let(:address) { attributes_for(:address) }

  before do
    login_as(user, scope: :user)
    visit new_setting_path
  end

  context 'when billing' do
    let(:billing) { user.addresses.create(attributes_for(:address, :billing)) }

    it 'when save billing address with empty fields' do
      first('input[type=submit]').click
      expect(page).to have_content error_message
    end

    it 'billing address exists' do
      billing
      visit new_setting_path

      expect(page).to have_field 'billing_form[first_name]', with: billing.first_name
      expect(page).to have_field 'billing_form[last_name]', with: billing.last_name
      expect(page).to have_field 'billing_form[address]', with: billing.address
      expect(page).to have_field 'billing_form[city]', with: billing.city
      expect(page).to have_field 'billing_form[zip]', with: billing.zip
      expect(page).to have_field 'billing_form[country]', with: billing.country
      expect(page).to have_field 'billing_form[phone]', with: billing.phone
    end

    it 'valid input' do
      fill_in_valid_input('billing_form')
      first('input[type=submit]').click
      expect(user.addresses.first.address_type).to eq(billing.address_type)
    end
  end

  context 'when shipping' do
    let(:shipping) { user.addresses.create(attributes_for(:address, :shipping)) }

    it 'when save billing address with empty fields' do
      all('input[type=submit]')[1].click
      expect(page).to have_content error_message
    end

    it 'shipping address exists' do
      shipping
      visit new_setting_path

      expect(page).to have_field 'shipping_form[first_name]', with: shipping.first_name
      expect(page).to have_field 'shipping_form[last_name]', with: shipping.last_name
      expect(page).to have_field 'shipping_form[address]', with: shipping.address
      expect(page).to have_field 'shipping_form[city]', with: shipping.city
      expect(page).to have_field 'shipping_form[zip]', with: shipping.zip
      expect(page).to have_field 'shipping_form[country]', with: shipping.country
      expect(page).to have_field 'shipping_form[phone]', with: shipping.phone
    end

    it 'valid input' do
      fill_in_valid_input('shipping_form')
      all('input[type=submit]')[1].click
      expect(user.addresses.first.address_type).to eq(shipping.address_type)
    end
  end
end

def fill_in_valid_input(type) # rubocop:disable Metrics/AbcSize:
  first("##{type}_first_name").set address[:first_name]
  first("##{type}_last_name").set address[:last_name]
  first("##{type}_address").set address[:address]
  first("##{type}_city").set address[:city]
  first("##{type}_zip").set address[:zip]
  first("##{type}_phone").set address[:phone]
end
