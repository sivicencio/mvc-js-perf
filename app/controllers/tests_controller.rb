class TestsController < ApplicationController
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
    redirect_to app_path(@app), notice: 'Test added'
  end

  def edit
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id])
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

  def update
    puts params[:probando]
    @app = App.find(params[:app_id])
    @test = @app.tests.find(params[:id]) 
    if @test.update(test_params)
      redirect_to@app
    else
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

  def test_params
    params.require(:test).permit(:name, :description, :total_runs, :script)
  end
end
