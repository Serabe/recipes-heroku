require 'rails_helper'

RSpec.describe 'step show', type: :request do

  let!(:step) { create :step }

  let(:json) { JSON.parse(response.body) }

  context 'when step exists' do

    before :each do
      get "/api/steps/#{step.to_param}"
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns a full step' do
      expect(json['step']['instruction']).to eq(step.instruction)
    end
  end

  context 'when step is not found' do

    before :each do
      get "/api/steps/something_re_a_lly_r_andom"
    end

    it 'returns a not found response' do
      expect(response).to be_not_found
    end
  end
end