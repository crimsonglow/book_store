require 'rails_helper'

RSpec.describe BookImage, type: :model do
  context 'with assosiations' do
    it { is_expected.to belong_to(:book).optional }
  end

  context 'with database columns' do
    it { is_expected.to have_db_column(:image_type).of_type(:integer).with_options(default: 'main') }
    it { is_expected.to have_db_column(:image_data).of_type(:text) }
  end

  context 'with enum types' do
    it { expect(BookImage.image_types[:main]).to eq 0 }
    it { expect(BookImage.image_types[:additional]).to eq 1 }
  end
end
