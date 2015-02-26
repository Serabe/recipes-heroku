module API
  class IngredientsController < ApplicationController

    before_action :load_resource, only: [:create, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do |exception|
      head :not_found
    end

    def index
      render json: Ingredient.all,
             each_serializer: ::IndexIngredientSerializer
    end

    def create
      @resource.save
      render_resource
    end

    def update
      @resource.update update_params
      render_resource
    end

    def destroy
      @resource.destroy
      head :no_content
    end

    protected

    def render_resource
      render json: @resource,
             status: status_code
    end

    def load_resource
      @resource = if action_name == 'create'
                    Ingredient.new create_params
                  else
                    Ingredient.find params[:id]
                  end
    end

    def status_code
      if @resource.valid?
        action_name == 'create' ? :created : :ok
      else
        :unprocessable_entity
      end
    end

    def create_params
      params.require(:ingredient).permit(:name)
    end

    def update_params
      params.require(:ingredient).permit(:name)
    end
  end
end
