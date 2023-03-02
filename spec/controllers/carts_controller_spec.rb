require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let!(:order) { create(:order) }

  describe 'GET #index' do
    before { get :index }

    it { expect(response).to have_http_status(:ok) }
  end
end
