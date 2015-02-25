require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  let(:new_ingredient) { build :ingredient }

  it "responds to name" do
    expect(new_ingredient).to respond_to(:name)
  end
end
