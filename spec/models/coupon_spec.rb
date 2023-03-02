require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context 'with assosiations' do
    it { is_expected.to belong_to(:order).optional }
  end

  context 'with database columns' do
    it { is_expected.to have_db_column(:key).of_type(:string) }
    it { is_expected.to have_db_column(:discount).of_type(:decimal).with_options(default: 10.0) }
  end
end
