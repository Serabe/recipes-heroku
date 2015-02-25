require 'rails_helper'

RSpec.describe 'ingredient index', type: :request do

  before :each do
    create_list :ingredient, 5
    get '/api/ingredients'
  end

  let(:json) { JSON.parse(response.body) }

  it 'is successful' do
    expect(response).to be_success
  end

  it 'contains ingredients' do
    expect(json['ingredients'].size).to equal(5)
  end

  it 'returns ingredients name' do
    json['ingredients'].each do |ing|
      expect(ing['name']).to be_present
    end
  end
end