require 'rails_helper'

RSpec.describe 'recipe index', type: :request do

  before :each do
    create_list :recipe, 5
    get '/api/recipes'
  end

  let(:json) { JSON.parse(response.body) }

  it 'is successful' do
    expect(response).to be_success
  end

  it 'contains recipes' do
    expect(json['recipes'].size).to equal(5)
  end

  it 'returns recipes name' do
    json['recipes'].each do |recipe|
      expect(recipe['name']).to be_present
    end
  end
end