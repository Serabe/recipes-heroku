require 'rails_helper'

RSpec.describe 'step index', type: :request do

  before :each do
    create_list :step, 5
    get '/api/steps'
  end

  let(:json) { JSON.parse(response.body) }

  it 'is successful' do
    expect(response).to be_success
  end

  it 'contains steps' do
    expect(json['steps'].size).to equal(5)
  end

  it 'returns steps name' do
    json['steps'].each do |ing|
      expect(ing['instruction']).to be_present
    end
  end
end