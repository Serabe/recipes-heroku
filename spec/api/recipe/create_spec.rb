require 'rails_helper'

RSpec.describe 'recipe create', type: :request do

  def create_with *options
    @attrs = {recipe: attributes_for(:recipe, *options)}
    post '/api/recipes', @attrs
  end
  alias_method :create_recipe, :create_with

  let(:json) { JSON.parse(response.body) }

  context 'with valid params' do
    before :each do
      expect {
        create_recipe
      }.to change(Recipe, :count).by(1)
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'sets the name properly' do
      expect(Recipe.last.name).to eq(@attrs[:recipe][:name])
    end

    it 'returns the name' do
      expect(json['recipe']['name']).to eq(@attrs[:recipe][:name])
    end

    it 'returns an id' do
      expect(json['recipe']['id']).to be_present
    end
  end

  context 'with invalid params' do

    before :each do
      expect {
        create_with name: ''
      }.not_to change(Recipe, :count)
    end

    it 'is not successful' do
      expect(response).to be_unprocessable
    end

    it 'returns the sent name' do
      expect(json['recipe']['name']).to eq('')
    end

    it 'returns a null id' do
      expect(json['recipe']['id']).to be_nil
    end

    it 'returs an errors object' do
      expect(json['recipe']['errors']).not_to be_nil
    end
  end
end