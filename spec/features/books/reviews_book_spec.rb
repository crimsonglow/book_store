require 'rails_helper'

RSpec.describe 'Review in book page', type: :feature do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  # rubocop:disable Metrics/LineLength
  let(:full_error_message) do
    "Title Consist of a-z, A-Z, 0-9, or one of !#$%&'*+-/=?^_`{|}~., Text review Consist of a-z, A-Z, 0-9, or one of !#$%&'*+-/=?^_`{|}~., Title can't be blank, and Text review can't be blank "
  end
  # rubocop:enable Metrics/LineLength

  before do
    login_as(user, scope: :user)
    visit book_path(book)
  end

  it 'sends review with invalid fields' do
    click_on(I18n.t('book_page.review.post'))
    expect(page).to have_content full_error_message
  end

  it 'sends review with valid fields' do
    fill_in 'text_review', with: 'test_title'
    fill_in 'title', with: 'test_body'
    click_on(I18n.t('book_page.review.post'))
    expect(page).to have_content I18n.t('book_page.review.success_add_comment')
  end
end
