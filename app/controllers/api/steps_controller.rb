module API
  class StepsController < ::API::ApplicationController

    self.resource_class = Step

    def index
      render json: resource_class.all,
             each_serializer: ::IndexStepSerializer
    end

    protected
    def create_params
      params.require(:step).permit(:position, :instruction, :recipe_id)
    end

    def update_params
      params.require(:step).permit(:position, :instruction, :recipe_id)
    end
  end
end
