module API
  class StepsController < ApplicationController

    before_action :load_resource, only: [:show, :create, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do |exception|
      head :not_found
    end

    def index
      render json: Step.all,
             each_serializer: ::IndexStepSerializer
    end

    def show
      render_resource
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
                    Step.new create_params
                  else
                    Step.find params[:id]
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
      params.require(:step).permit(:position, :instruction)
    end

    def update_params
      params.require(:step).permit(:postion, :instruction)
    end
  end
end
