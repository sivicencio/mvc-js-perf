class InstancesController < ApplicationController
  authorize_resource

  def new
    @app = App.find(params[:app_id])
  end

  def create
    @app = App.find(params[:app_id])
    @app.instances.create(instance_params)
    redirect_to app_path(@app), notice: 'Instance added'
  end

  def destroy
    @app = App.find(params[:app_id])
    @instance = @app.instances.find(params[:id])
    @instance.destroy
    redirect_to app_path(@app), notice: 'Instance deleted'
  end

  private

  def instance_params
    params.require(:instance).permit(:url, :framework_id)
  end
end