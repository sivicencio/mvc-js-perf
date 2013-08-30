require 'faraday'

class RunsController < ApplicationController
  include RunsHelper

  def index
    @test = Test.find(params[:test_id])
    @instance = Instance.find(params[:instance_id])
    @runs = @test.runs.where(instance_id: params[:instance_id])
    @ready = true
    load_time_array = Array.new
    ttfb_array = Array.new
    @runs.each do |run|
      run.data = get_run_data run.url_json
      @ready = false if run.data['statusCode'] != 200

      if @ready
        load_time_array << run.data['runs']['1']['firstView']['loadTime']
        ttfb_array << run.data['runs']['1']['firstView']['TTFB']
      end
    end

    if @ready
      @average_load_time = load_time_array.sum.to_f / load_time_array.size
      @average_ttfb =ttfb_array.sum.to_f / ttfb_array.size
    end
  end

  def run_test
    @test = Test.find(params[:test_id])
    @instance = Instance.find(params[:instance_id])
    @runs = @test.runs.where(instance_id: params[:instance_id])
    total = params[:total].to_i

    # No more runs than those specified by the test have to be executed    
    redirect_to test_instance_runs_path(@test, @instance), notice: 'sadasa' and return if @test.total_runs < @runs.size + total

    exec_runs @test, @instance, @runs.size, total
    redirect_to test_instance_runs_path(@test, @instance)
  end

  def clear_runs
    @test = Test.find(params[:test_id])
    @test.runs.where(instance_id: params[:instance_id]).destroy_all
    redirect_to test_instance_runs_path(@test, params[:instance_id])
  end
end