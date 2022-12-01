require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'with assosiations' do
    it { is_expected.to have_many(:book_authors) }
    it { is_expected.to have_many(:books).through(:book_authors).dependent(:destroy) }
  end

  context 'with database columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:string) }
  end
end
