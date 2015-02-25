module Api
  class IngredientsController < ApplicationController

    def index
      render json: Ingredient.all, each_serializer: IndexIngredientSerializer
    end
  end
end
