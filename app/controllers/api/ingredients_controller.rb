module API
  class IngredientsController < ApplicationController

    def index
      render json: Ingredient.all, each_serializer: ::IndexIngredientSerializer
    end

    def create
      ing = Ingredient.new create_params

      ing.save

      render json: ing, serializer: ::ShowIngredientSerializer
    end

    protected

    def create_params
      params.require(:ingredient).permit(:name)
    end
  end
end
