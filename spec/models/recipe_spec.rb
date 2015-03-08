require 'rails_helper'

RSpec.describe Recipe, type: :model do

  let(:recipe) { build :recipe }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end

  describe '#name' do

    it 'responds to name' do
      expect(recipe).to respond_to(:name)
    end

    it 'is present' do
      expect(build :recipe, name: nil).not_to be_valid
    end

    it 'is at least 5 chars long' do
      expect(build :recipe, name: '1234').not_to be_valid
    end
  end

  describe '#description' do

    it 'responds to description' do
      expect(recipe).to respond_to(:description)
    end

    it 'is present' do
      expect(build :recipe, description: nil).not_to be_valid
    end

    it 'is at least 10 chars long' do
      expect(build :recipe, description: '123456789').not_to be_valid
    end
  end
end
