class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params) 
    if @app.save
      redirect_to @app
    else
      render 'new'
    end    
  end

  def edit
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])
 
    if @app.update(app_params)
      redirect_to apps_path
    else
      render 'edit'
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy
    redirect_to apps_path, :notice => "App deleted."
  end

  private

  def app_params
    params.require(:app).permit(:name, :project_url)
  end
end
