class TestsController < ApplicationController
  before_action :initialize_webpagetest, only: [:new, :edit, :update]
  before_action :get_locations, only: [:new, :edit]

  def show
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
  end

  def new
    @app = App.find(params[:app_id])
    @test = @app.tests.build
  end  

  def create
    @app = App.find(params[:app_id])
    @test = @app.tests.create(test_params)
    location_hash = Hashie::Mash.new(eval location)
    generate_test_settings location_hash if location.present?
    redirect_to app_path(@app), notice: 'Test added'
  end

  def edit
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
  end

  def update
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
    location = params[:test][:location]
    if @test.update(test_params)
      location_hash = Hashie::Mash.new(eval location)
      generate_test_settings location_hash if location.present?
      redirect_to @app
    else
      get_locations
      render 'edit'
    end
  end

  def destroy
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
    @test.destroy
    redirect_to app_path(@app), notice: 'Test deleted'
  end

  private  

  def generate_test_settings(settings_hash)
    # Generate label, location, browser
    @test.test_settings.clear if not @test.test_settings.empty?
    @test.test_settings.create(name: 'label', value: settings_hash.Label)
    @test.test_settings.create(name: 'location', value: settings_hash.location)
    @test.test_settings.create(name: 'browser', value: settings_hash.Browser)
  end

  def get_locations
    @locations = @wpt.locations.to_hash
  end

  def test_params
    params.require(:test).permit(:name, :description, :total_runs, :script, :location)
  end
end
