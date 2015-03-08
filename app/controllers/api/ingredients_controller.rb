module API
  class IngredientsController < ::API::ApplicationController

    self.resource_class = Ingredient

    def index
      render json: resource_class.all,
             each_serializer: ::IndexIngredientSerializer
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
