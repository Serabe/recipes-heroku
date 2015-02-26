require 'rails_helper'

RSpec.describe 'ingredient destroy', type: :request do

  let!(:ingredient) { create :ingredient }

  def destroy_ingredient param=nil
    param ||= ingredient.to_param
    delete "/api/ingredients/#{param}"
  end

  context 'with an existing ingredient' do
    before :each do
      destroy_ingredient
    end

    it 'returns a not content response' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'with a non-existing ingredient' do
    before :each do
      destroy_ingredient "non-existing"
    end

    it 'returns a not found response' do
      expect(response).to be_not_found
    end
  end
end