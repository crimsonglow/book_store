require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { FactoryBot.create(:book) }

  context 'GET #index' do
    before { get :index, params: { sort_by: :asc_price } }

    it { is_expected.to respond_with(200) }
  end

  context 'GET #show' do
    before { get :show, params: { id: book.id } }

    it { is_expected.to respond_with(200) }
  end

  context 'when routes' do
    it { is_expected.to route(:get, "/books/#{book.id}").to(action: :show, id: book.id) }

    it {
      expect(subject).to route(:get, "/categories/#{book.category.id}/books").to(action: :index,
                                                                                 category_id: book.category.id)
    }
  end
end
