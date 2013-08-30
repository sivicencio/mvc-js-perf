module TestsHelper
  def format_settings(test_settings)
    items = test_settings.map { |setting|
      content_tag :li do
        content_tag :div, setting.value
      end if setting.name != 'location'
    }.join.html_safe
    content_tag :ul, items
  end
end
