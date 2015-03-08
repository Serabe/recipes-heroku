require 'rails_helper'

RSpec.describe 'step update', type: :request do

  let!(:step) { create :step }
  let(:updated_instruction) { step.instruction * 2 }

  def update_with *options
    @attrs = attributes_for :step, *options
    patch "/api/steps/#{step.to_param}", {step: @attrs}
  end
  alias_method :update_step, :update_with

  let(:json) { JSON.parse(response.body) }

  context 'with valid params' do

    before :each do
      update_with instruction: updated_instruction
    end

    it 'returns a success request' do
      expect(response).to be_success
    end

    it 'returns the object with the new instruction' do
      expect(json['step']['instruction']).to eq(updated_instruction)
    end

    it 'returns the id' do
      expect(json['step']['id']).to eq(step.id)
    end
  end

  context 'with invalid params' do

    before :each do
      update_with instruction: ''
    end

    it 'returns an unprocessable status' do
      expect(response).to be_unprocessable
    end

    it 'returns the object with the invalid name' do
      expect(json['step']['instruction']).to eq('')
    end

    it 'returns the id' do
      expect(json['step']['id']).to eq(step.id)
    end

    it 'returns an errors object' do
      expect(json['step']['errors']).not_to be_nil
    end
  end

  context 'with an id that cannot be found' do

    before :each do
      patch '/api/steps/something_something_random'
    end

    it 'gets a not found' do
      expect(response).to be_not_found
    end
  end
end