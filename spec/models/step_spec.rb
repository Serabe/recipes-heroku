require 'rails_helper'

RSpec.describe Step, type: :model do

  let(:step) { build :step }

  describe '#position' do
    it 'responds to position' do
      expect(step).to respond_to(:position)
    end

    it 'is required' do
      expect(build :step, position: nil).not_to be_valid
    end

    it 'is an integer' do
      expect(build :step, position: 2.4).not_to be_valid
    end

    it 'is at least 0' do
      expect(build :step, position: -1).not_to be_valid
    end
  end

  describe '#instruction' do

    it 'responds to instruction' do
      expect(step).to respond_to(:instruction)
    end

    it 'is required' do
      expect(build :step, instruction: nil).not_to be_valid
    end

    it 'is at least 5 characters long' do
      expect(build :step, instruction: '1234').not_to be_valid
    end
  end
end
