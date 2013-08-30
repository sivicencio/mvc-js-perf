module RunsHelper
  def get_pre_script(url, html=false)
    pre_script = "combineSteps\nnavigate " + url + "\n"
    return output_script(pre_script) if html
    pre_script
  end

  def get_full_script(url, script, html=false)
    full_script = get_pre_script(url) + script
    return output_script(full_script) if html
    full_script
  end

  def output_script(script)
    script.split("\n").map {|line| line + tag(:br) }.join.html_safe
  end

  def exec_runs(test, instance, current_runs, total)
    conn = Faraday.new(:url => ENV["WEBPAGETEST_BASE_URI"]) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    script = get_pre_script(instance.url)
    total.times do |n|
      response = conn.get do |req|
        req.url '/' + ENV["WEBPAGETEST_TEST_BASE"]
        req.params['k'] = ENV["WEBPAGETEST_API_KEY"]
        req.params['f'] = 'json'
        req.params['script'] = script
      end
      response_body = JSON.parse(response.body)
      if response_body['statusCode'] == 200
        data = response_body['data']
        run = test.runs.create(instance_id: instance.id, url: data['userUrl'], url_json: data['jsonUrl'], run_number: current_runs + 1)
        current_runs += 1
      end
    end
  end

  def get_run_data(url)
    response = Faraday.get url
    response_body = JSON.parse(response.body)
    data = response_body['data']
    data['statusCode'] = response_body['statusCode']
    data
  end
end