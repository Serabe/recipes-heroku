require 'rails_helper'

RSpec.describe 'ingredient show', type: :request do

  let!(:ingredient) { create :ingredient }

  let(:json) { JSON.parse(response.body) }

  context 'when ingredient exists' do

    before :each do
      get "/api/ingredients/#{ingredient.to_param}"
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns a full ingredient' do
      expect(json['ingredient']['name']).to eq(ingredient.name)
    end
  end

  context 'when ingredient is not found' do

    before :each do
      get "/api/ingredients/something_re_a_lly_r_andom"
    end

    it 'returns a not found response' do
      expect(response).to be_not_found
    end
  end
end