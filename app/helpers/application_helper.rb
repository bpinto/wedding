module ApplicationHelper
  def navigation_link_to(name = nil, options = nil, html_options = {}, &block)
    if request.path == root_path
      html_options.merge!(class: 'nav-link', data: { scroll: true })
    else
      options = root_path + options
    end

    link_to(name, options, html_options, &block)
  end
end
