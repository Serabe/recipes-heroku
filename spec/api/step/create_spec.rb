require 'rails_helper'

RSpec.describe 'step create', type: :request do

  def create_with *options
    @attrs = {step: attributes_for(:step, *options)}
    post '/api/steps', @attrs
  end
  alias_method :create_step, :create_with

  let(:json) { JSON.parse(response.body) }

  context 'with valid params' do
    before :each do
      expect {
        create_step
      }.to change(Step, :count).by(1)
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'sets the name properly' do
      expect(Step.last.instruction).to eq(@attrs[:step][:instruction])
    end

    it 'returns the name' do
      expect(json['step']['instruction']).to eq(@attrs[:step][:instruction])
    end

    it 'returns an id' do
      expect(json['step']['id']).to be_present
    end
  end

  context 'with invalid params' do

    before :each do
      expect {
        create_with instruction: ''
      }.not_to change(Step, :count)
    end

    it 'is not successful' do
      expect(response).to be_unprocessable
    end

    it 'returns the sent instruction' do
      expect(json['step']['instruction']).to eq('')
    end

    it 'returns a null id' do
      expect(json['step']['id']).to be_nil
    end

    it 'returs an errors object' do
      expect(json['step']['errors']).not_to be_nil
    end
  end
end