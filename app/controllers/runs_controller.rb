require 'faraday'

class RunsController < ApplicationController
  include RunsHelper
  before_action :initialize_webpagetest, only: [:run_test]

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
    redirect_to test_instance_runs_path(@test, @instance), notice: 'No more runs than those specified by the test have to be executed' and return if @test.total_runs < @runs.size + total

    exec_runs total
    redirect_to test_instance_runs_path(@test, @instance)
  end

  def clear_runs
    @test = Test.find(params[:test_id])
    @test.runs.where(instance_id: params[:instance_id]).destroy_all
    redirect_to test_instance_runs_path(@test, params[:instance_id])
  end

  private

  def exec_runs(total)
    current_runs = @runs.size
    script = get_pre_script(@instance.url)

    # Handle browser in location id (Chrome and Firefox with :)
    # WPT does not understand if location is not passed in that way
    location = @test.test_settings.location.first.value
    browser = @test.test_settings.browser.first.value
    cool_browsers = ['Chrome', 'Firefox']
    if cool_browsers.include?(browser)
      location = (location =~ /_(wptdriver)$/i) ? location.sub!(/_(wptdriver)$/i, ':' + browser) : location + ':' + browser
    end

    total.times do |n|
      response = @wpt.run_test do |params|
        params.script = script
        params.location = location
        params.mobile = 1 if browser == 'Chrome'
      end
      run = @test.runs.create(instance: @instance, url: response.raw.data.userUrl, url_json: response.raw.data.jsonUrl, run_number: current_runs + 1)
      current_runs += 1
    end
  end
end