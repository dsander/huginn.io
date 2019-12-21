# frozen_string_literal: true

module ApplicationHelper
  def nav_link(text, path, *controller)
    content_tag('li', class: active_nav_class(controller: controller)) do
      link_to(text, path)
    end
  end

  def active_nav_class(path)
    path[:controller].include?(params[:controller]) ? 'active' : ''
  end

  def markdown(source)
    Kramdown::Document.new(source || "").to_html.html_safe
  end
end
