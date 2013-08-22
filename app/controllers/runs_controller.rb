require 'faraday'
require 'addressable/uri'

class RunsController < ApplicationController
  include RunsHelper

  def index
    @test = Test.find(params[:test_id])
    @instance = Instance.find(params[:instance_id])
    @runs = @test.runs.where(instance_id: params[:instance_id])
    
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