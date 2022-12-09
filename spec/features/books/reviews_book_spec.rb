require 'rails_helper'

RSpec.describe 'Review in book page', type: :feature do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let(:expected_errors) do
    {
      blank: I18n.t('errors.messages.blank'),
      validate_review: I18n.t('validate.validate_review')
    }
  end
  let(:success_massage) { I18n.t('book_page.review.success_add_comment') }

  before do
    login_as(user, scope: :user)
    visit book_path(book)
  end

  context 'when review with invalid fields' do
    before { click_on(I18n.t('book_page.review.post')) }

    it { expect(page).to have_content(expected_errors[:blank]) }
    it { expect(page).to have_content(expected_errors[:validate_review]) }
  end

  it 'sends review with valid fields' do
    fill_in 'text_review', with: 'test_title'
    fill_in 'title', with: 'test_body'
    click_on(I18n.t('book_page.review.post'))
    expect(page).to have_content success_massage
  end
end
