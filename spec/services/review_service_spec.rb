require 'rails_helper'

RSpec.describe ReviewService do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:review_attr) { attributes_for(:review) }

  let(:count_comment_after_create) { 1 }

  describe 'create review' do
    subject(:current_subject) { described_class.new(params) }

    context 'when success' do
      let(:params) { { title: review_attr[:title], text_review: review_attr[:title], rating: 4, current_user: user.id, current_book: book.id } }

      before { current_subject.call }

      it { expect(Review.first).to be_truthy }
    end

    context 'when failure' do
      let(:params) { {} }

      it { expect(current_subject.call).to eq(nil) }
    end
  end
end
