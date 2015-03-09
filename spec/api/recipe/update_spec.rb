require 'rails_helper'

RSpec.describe 'recipe update', type: :request do

  let!(:recipe) { create :recipe }
  let(:updated_name) { recipe.name * 2 }

  def update_with *options
    @attrs = attributes_for :recipe, *options
    patch "/api/recipes/#{recipe.to_param}", {recipe: @attrs}
  end
  alias_method :update_recipe, :update_with

  let(:json) { JSON.parse(response.body) }

  context 'with valid params' do

    before :each do
      update_with name: updated_name
    end

    it 'returns a success request' do
      expect(response).to be_success
    end

    it 'returns the object with the new instruction' do
      expect(json['recipe']['name']).to eq(updated_name)
    end

    it 'returns the id' do
      expect(json['recipe']['id']).to eq(recipe.id)
    end
  end

  context 'with invalid params' do

    before :each do
      update_with name: ''
    end

    it 'returns an unprocessable status' do
      expect(response).to be_unprocessable
    end

    it 'returns the object with the invalid name' do
      expect(json['recipe']['name']).to eq('')
    end

    it 'returns the id' do
      expect(json['recipe']['id']).to eq(recipe.id)
    end

    it 'returns an errors object' do
      expect(json['recipe']['errors']).not_to be_nil
    end
  end

  context 'with an id that cannot be found' do

    before :each do
      patch '/api/recipes/something_something_random'
    end

    it 'gets a not found' do
      expect(response).to be_not_found
    end
  end
end