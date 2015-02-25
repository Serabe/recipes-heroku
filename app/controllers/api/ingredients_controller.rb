module API
  class IngredientsController < ApplicationController

    def index
      render json: Ingredient.all, each_serializer: ::IndexIngredientSerializer
    end

    def create
      ingredient = Ingredient.new create_params

      if ingredient.save
        render json: ingredient, serializer: ::ShowIngredientSerializer
      else
        render json: ingredient, serializer: ::ErrorIngredientSerializer, status: :unprocessable_entity
      end
    end

    def update
      ingredient = Ingredient.find params[:id]

      if ingredient.update update_params
        render json: ingredient, serializer: ::ShowIngredientSerializer
      else
        render json: ingredient, serializer: ::ErrorIngredientSerializer, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    protected

    def create_params
      params.require(:ingredient).permit(:name)
    end

    def update_params
      params.require(:ingredient).permit(:name)
    end
  end
end
