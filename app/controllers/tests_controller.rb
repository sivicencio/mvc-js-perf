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
  end

  def update
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
