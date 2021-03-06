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
end