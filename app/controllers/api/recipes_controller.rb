module API
  class RecipesController < ::API::ApplicationController

    self.resource_class = Recipe

    def index
      render json: resource_class.all,
             each_serializer: ::IndexRecipeSerializer
    end

    protected
    def create_params
      params.require(:recipe).permit(:name, :description, steps_attributes: [:position, :instruction])
    end

    def update_params
      params.require(:recipe).permit(:name, :description, steps: [:position, :instruction])
    end
  end
end