require 'rails_helper'

RSpec.describe 'step destroy', type: :request do

  let!(:step) { create :step }

  def destroy_step param=nil
    param ||= step.to_param
    delete "/api/steps/#{param}"
  end

  context 'with an existing step' do
    before :each do
      destroy_step
    end

    it 'returns a not content response' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'with a non-existing step' do
    before :each do
      destroy_step "non-existing"
    end

    it 'returns a not found response' do
      expect(response).to be_not_found
    end
  end
end