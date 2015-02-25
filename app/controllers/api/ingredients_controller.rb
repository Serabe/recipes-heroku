module API
  class IngredientsController < ApplicationController

    def index
      render json: Ingredient.all, each_serializer: ::IndexIngredientSerializer
    end

    def create
      ing = Ingredient.new create_params

      if ing.save
        render json: ing, serializer: ::ShowIngredientSerializer
      else
        render json: ing, serializer: ::ErrorIngredientSerializer, status: :unprocessable_entity
      end
    end

    protected

    def create_params
      params.require(:ingredient).permit(:name)
    end
  end
end
