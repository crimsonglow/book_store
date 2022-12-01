require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'when get to /' do
    before { get(:index) }

    it { is_expected.to respond_with(200) }
  end
end
