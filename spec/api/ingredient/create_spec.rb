require 'rails_helper'

RSpec.describe 'ingredient create', type: :request do

  def create_with *options
    @attrs = {ingredient: attributes_for(:ingredient, *options)}
    post '/api/ingredients', @attrs
  end
  alias_method :create_ingredient, :create_with

  let(:json) { JSON.parse(response.body) }

  context 'with valid params' do
    before :each do
      expect {
        create_ingredient
      }.to change(Ingredient, :count).by(1)
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'sets the name properly' do
      expect(Ingredient.last.name).to eq(@attrs[:ingredient][:name])
    end

    it 'returns the name' do
      expect(json['ingredient']['name']).to eq(@attrs[:ingredient][:name])
    end

    it 'returns an id' do
      expect(json['ingredient']['id']).to be_present
    end
  end

  context 'with invalid params' do

    before :each do
      expect {
        create_with name: ''
      }.not_to change(Ingredient, :count)
    end

    it 'is not successful' do
      expect(response).to be_unprocessable
    end

    it 'returns the sent name' do
      expect(json['ingredient']['name']).to eq('')
    end

    it 'returns a null id' do
      expect(json['ingredient']['id']).to be_nil
    end

    it 'returs an errors object' do
      expect(json['ingredient']['errors']).not_to be_nil
    end
  end
end