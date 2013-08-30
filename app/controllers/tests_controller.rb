class TestsController < ApplicationController
  def show
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
  end

  def new
    @app = App.find(params[:app_id])
    @test = @app.tests.build
    get_locations
  end  

  def create
    @app = App.find(params[:app_id])
    @test = @app.tests.create(test_params)
    redirect_to app_path(@app), notice: 'Test added'
  end

  def edit
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
    get_locations
  end

  def update
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
    location = params[:test][:location]
    if @test.update(test_params)
      location_hash = eval location
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
    @test.test_settings.create(name: 'label', value: settings_hash['Label'])
    @test.test_settings.create(name: 'location', value: settings_hash['location'])
    @test.test_settings.create(name: 'browser', value: settings_hash['Browser'])
  end

  def get_locations
    conn = Faraday.new(:url => ENV["WEBPAGETEST_BASE_URI"]) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get do |req|
      req.url '/' + ENV["WEBPAGETEST_LOCATIONS_BASE"]
      req.params['k'] = ENV["WEBPAGETEST_API_KEY"]
      req.params['f'] = 'json'
    end
    response_body = JSON.parse(response.body)
    if response_body['statusCode'] == 200
      @locations = response_body['data']
    end
  end

  def test_params
    params.require(:test).permit(:name, :description, :total_runs, :script, :location)
  end
end
