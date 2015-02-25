require 'rails_helper'

RSpec.describe 'ingredient update', type: :request do

  let!(:ingredient) { create :ingredient }
  let(:updated_name) { ingredient.name * 2 }

  def update_with *options
    @attrs = attributes_for :ingredient, *options
    patch "/api/ingredients/#{ingredient.to_param}", {ingredient: @attrs}
  end
  alias_method :update_ingredient, :update_with

  let(:json) { JSON.parse(response.body) }

  context 'with valid params' do

    before :each do
      update_with name: updated_name
    end

    it 'returns a success request' do
      expect(response).to be_success
    end

    it 'returns the object with the new name' do
      expect(json['ingredient']['name']).to eq(updated_name)
    end

    it 'returns the id' do
      expect(json['ingredient']['id']).to eq(ingredient.id)
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
      expect(json['ingredient']['name']).to eq('')
    end

    it 'returns the id' do
      expect(json['ingredient']['id']).to eq(ingredient.id)
    end

    it 'returns an errors object' do
      expect(json['ingredient']['errors']).not_to be_nil
    end
  end

  context 'with an id that cannot be found' do

    before :each do
      patch '/api/ingredients/something_something_random'
    end

    it 'gets a not found' do
      expect(response).to be_not_found
    end
  end
end