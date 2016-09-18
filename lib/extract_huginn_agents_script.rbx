agents = []
HuginnAgent.require!
Agent.descendants.each do |klass|
  instance = klass.new(user_id: 1)
  agents << {
    name: klass.to_s.gsub(/^.*::/, ''),
    description: instance.html_description,
    creates_events: !klass.cannot_create_events?,
    receives_events: !klass.cannot_receive_events?,
    consumes_file_pointer: !!klass.try(:consumes_file_pointer?),
    emits_file_pointer: !!klass.try(:emits_file_pointer?),
    controls_agents: klass.can_control_other_agents?,
    dry_runs: instance.can_dry_run?,
    form_configurable: !!klass.try(:is_form_configurable?),
    oauth_service: klass.instance_variable_get(:@valid_oauth_providers).try(:first)
  }
end
puts agents.to_json
