require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review_attributes) { attributes_for(:review) }
  let!(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'POST #create' do
    subject(:create_review) { post :create, params: params }

    login_user

    context 'when success' do
      let(:params) do
        { title: review_attributes[:title], text_review: review_attributes[:text_review], current_user: user.id,
          current_book: book.id }
      end

      it 'sets flash message' do
        create_review
        expect(flash[:success]).to be_present
      end

      it { is_expected.to redirect_to(book_path(book.id)) }
    end

    context 'when failure' do
      let(:params) { { title: '', text_comment: '', current_user: user.id, current_book: book.id } }

      it 'sets flash message' do
        create_review
        expect(flash[:error]).to be_present
      end

      it { is_expected.to redirect_to(book_path(book.id)) }
    end
  end
end
