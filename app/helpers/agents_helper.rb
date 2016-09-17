module AgentsHelper
  FEATURE_ATTRIBUTES = [:creates_events, :receives_events, :consumes_file_pointer, :emits_file_pointer, :controls_agents, :dry_runs, :form_configurable].freeze

  def agent_name(klass)
    klass.underscore.humanize.titleize
  end

  def features(agent)
    features = FEATURE_ATTRIBUTES.map do |attr|
      feature_label(attr) if agent.send(attr)
    end.compact
    features << feature_label(agent.oauth_service, 'success') if agent.oauth_service
    features.join('&nbsp;').html_safe
  end

  def feature_label(attr, type = 'primary')
    content_tag(:span, attr.to_s.humanize, class: "label label-#{type}")
  end
end
