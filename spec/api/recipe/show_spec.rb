require 'rails_helper'

RSpec.describe 'recipe show', type: :request do

  let!(:recipe) { create :recipe }

  let(:json) { JSON.parse(response.body) }

  context 'when recipe exists' do

    before :each do
      get "/api/recipes/#{recipe.to_param}"
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns a full recipe' do
      expect(json['recipe']['name']).to eq(recipe.name)
    end
  end

  context 'when recipe is not found' do

    before :each do
      get "/api/recipes/something_re_a_lly_r_andom"
    end

    it 'returns a not found response' do
      expect(response).to be_not_found
    end
  end
end