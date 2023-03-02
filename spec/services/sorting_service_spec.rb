require 'rails_helper'

RSpec.describe SortingService do
  let(:category) { create(:category) }
  let!(:book1) { create(:book, title: 'Ab', category: category, price: 2) }
  let!(:book2) { create(:book, title: 'Ba', category: category, price: 1) }
  let(:all_books) { Book.all }

  describe 'sorting books' do
    shared_examples 'returns expected result' do
      subject(:current_subject) { described_class.new(all_books, params) }

      it do
        expect(current_subject.call).to eq(book_sequence)
      end
    end

    context 'when sorting newest' do
      let(:params) { { sort_by: :newest_first, category_id: category.id } }
      let(:book_sequence) { [book2, book1] }

      include_examples 'returns expected result'
    end

    context 'when sorting asc price' do
      let(:params) { { sort_by: :asc_price, category_id: category.id } }
      let(:book_sequence) { [book2, book1] }

      include_examples 'returns expected result'
    end

    context 'when sorting desc price' do
      let(:params) { { sort_by: :desc_price, category_id: category.id } }
      let(:book_sequence) { [book1, book2] }

      include_examples 'returns expected result'
    end

    context 'when sorting asc title' do
      let(:params) { { sort_by: :asc_title, category_id: category.id } }
      let(:book_sequence) { [book1, book2] }

      include_examples 'returns expected result'
    end

    context 'when sorting desc title' do
      let(:params) { { sort_by: :desc_title, category_id: category.id } }
      let(:book_sequence) { [book2, book1] }

      include_examples 'returns expected result'
    end
  end
end
