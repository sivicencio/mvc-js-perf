require 'faraday'

class RunsController < ApplicationController
  include RunsHelper
  before_action :initialize_webpagetest, only: [:index, :run_test]
  authorize_resource
  skip_authorize_resource only: [:index]

  def index
    @test = Test.find(params[:test_id])
    @instance = Instance.find(params[:instance_id])
    @runs = @test.runs.where(instance_id: params[:instance_id])

    # Get metric sets if not been set yet (only if they are available)
    @runs.each do |run|
      if run.metric_sets.size == 0
        response = @wpt.test_result(run.wpt_id)
        if response.get_status == :completed
          # All metric sets can be set now (first_view and repeat_view)
          metric_set = run.metric_sets.create({
            ms_type: 'first_view',
            load_time: response.result.runs[1].firstView.loadTime,
            ttfb: response.result.runs[1].firstView.TTFB,
            start_render: response.result.runs[1].firstView.render,
            fully_loaded: response.result.runs[1].firstView.fullyLoaded,
            speed_index: response.result.runs[1].firstView.SpeedIndex,
            dom_elements: response.result.runs[1].firstView.domElements
          })

          metric_set = run.metric_sets.create({
            ms_type: 'repeat_view',
            load_time: response.result.runs[1].repeatView.loadTime,
            ttfb: response.result.runs[1].repeatView.TTFB,
            start_render: response.result.runs[1].repeatView.render,
            fully_loaded: response.result.runs[1].repeatView.fullyLoaded,
            speed_index: response.result.runs[1].repeatView.SpeedIndex,
            dom_elements: response.result.runs[1].repeatView.domElements
          })
        end
      end
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
    location = @test.test_settings.location.value
    browser = @test.test_settings.browser.value
    cool_browsers = ['Chrome', 'Firefox']
    if cool_browsers.include?(browser)
      location = (location =~ /_(wptdriver)$/i) ? location.sub!(/_(wptdriver)$/i, ':' + browser) : location + ':' + browser
    end

    total.times do |n|
      response = @wpt.run_test do |params|
        params.script = script
        params.location = location
        params.video = 1
      end
      run = @test.runs.create({
        instance: @instance,
        run_number: current_runs + 1,
        wpt_id: response.test_id,
        url: response.raw.data.userUrl,
        url_json: response.raw.data.jsonUrl        
      })
      current_runs += 1
    end
  end
end