module ApplicationHelper
  def navigation_link_to(name = nil, options = nil, html_options = {}, &block)
    html_options.merge!(data: { scroll: true })

    link_to(name, options, html_options, &block)
  end
end
