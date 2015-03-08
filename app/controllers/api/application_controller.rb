module API
  class ApplicationController < ::ApplicationController

    rescue_from ActiveRecord::RecordNotFound do |exception|
      head :not_found
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

    class << self
      attr_accessor :resource_class

      def inherited base
        base.send(:before_action, :load_resource, only: [:show, :create, :update, :destroy])
      end
    end
    protected

    def render_resource
      render json: @resource,
             status: status_code
    end

    def status_code
      if @resource.valid?
        action_name == 'create' ? :created : :ok
      else
        :unprocessable_entity
      end
    end

    def resource_class
      self.class.resource_class
    end

    def load_resource
      @resource = if action_name == 'create'
                    resource_class.new create_params
                  else
                    resource_class.find params[:id]
                  end
    end

  end
end