require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let(:order) { create(:order) }
  let!(:book) { create(:book) }

  describe 'POST #create' do
    subject(:create_line_item) { post :create, params: params }

    context 'when success' do
      let(:params) { { line_item: { current_book: book } } }

      it 'sets flash message' do
        create_line_item
        expect(flash[:success]).to be_present
      end

      it { expect(create_line_item).to redirect_to root_path }
    end

    context 'when failure' do
      let(:params) { { line_item: { current_book: '' } } }

      it 'sets flash message' do
        create_line_item
        expect(flash[:error]).to be_present
      end

      it { expect(create_line_item).to redirect_to root_path }
    end
  end

  describe 'PUT #update' do
    subject(:update_line_item) { put :update, params: params }

    let(:line_item) { order.line_items.last }
    let(:params) { { id: line_item.id, plus: true } }

    it { expect(response).to have_http_status(:ok) }
    it { expect(update_line_item).to redirect_to carts_path }
  end

  describe 'DELETE #destroy' do
    subject(:destroy_line_item) { delete :destroy, params: params }

    before { cookies[:current_order_id] = order.id }

    let(:params) { { id: order.line_items.last.book.id } }

    it 'sets flash message' do
      destroy_line_item
      expect(flash[:success]).to be_present
    end

    it { expect(destroy_line_item).to redirect_to root_path }
  end
end
