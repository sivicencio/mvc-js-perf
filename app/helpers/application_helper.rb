module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def nav_link_to(link_text, link_path)
    if (params[:controller] =~ /apps|tests|instances/) 
      class_name = link_path == apps_path ? 'active' : ''
    elsif (params[:controller] =~ /frameworks/) 
      class_name = link_path == frameworks_path ? 'active' : ''
    elsif (params[:controller] =~ /users/) 
      class_name = link_path == users_path ? 'active' : ''
    else
      class_name = current_page?(link_path) ? 'active' : ''
    end

    content_tag(:li, class: class_name) do
      link_to link_text, link_path
    end
  end
  
end
