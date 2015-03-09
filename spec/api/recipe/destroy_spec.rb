require 'rails_helper'

RSpec.describe 'recipe destroy', type: :request do

  let!(:recipe) { create :recipe }

  def destroy_recipe param=nil
    param ||= recipe.to_param
    delete "/api/recipes/#{param}"
  end

  context 'with an existing recipe' do
    before :each do
      destroy_recipe
    end

    it 'returns a not content response' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'with a non-existing recipe' do
    before :each do
      destroy_recipe "non-existing"
    end

    it 'returns a not found response' do
      expect(response).to be_not_found
    end
  end
end