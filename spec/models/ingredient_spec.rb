require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  let(:new_ingredient) { build :ingredient }

  describe '#name' do
    it 'responds to name' do
      expect(new_ingredient).to respond_to(:name)
    end

    it 'is required' do
      expect(build(:ingredient, name: '')).not_to be_valid
      expect(build(:ingredient, name: '    ')).not_to be_valid
    end
  end
end
