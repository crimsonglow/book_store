require 'rails_helper'

RSpec.describe EmailService do
  let(:user) { create(:user) }
  let(:new_email) { FFaker::Internet.email }

  describe 'update email success' do
    subject(:current_subject) { described_class.new(params, user) }

    let(:params) { { email: new_email, user_id: user.id } }

    before { current_subject.save }

    it { expect(user.email).to eq(params[:email]) }
  end

  describe 'update email failed' do
    subject(:current_subject) { described_class.new(params, user) }

    let(:params) { { email: '', user_id: user.id } }

    it { expect(current_subject.save).to be_nil }
  end
end
