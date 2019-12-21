# frozen_string_literal: true

class HuginnAgent
  attr_reader :data

  def initialize(data)
    @data = data
  end

  %w[name guid schedule propagate_immediately keep_events_for disabled options type].each do |attr|
    define_method(attr.to_sym) do
      data[attr]
    end
  end

  def id
    guid.gsub(/\D/, '').to_i
  end

  def short_type
    type.gsub(/^.*::/, '')
  end

  def human_name
    short_type.sub('Agent', '')
  end

  def model
    @agent ||= Agent.find_by(name: short_type)
  end

  def unavailable?
    !!disabled
  end

  def propagate_immediately?
    !!propagate_immediately
  end

  def can_control_other_agents?
    model.try(:controls_agents)
  end

  def control_action
    options['action']
  end

  def receivers
    @receivers ||= []
  end

  def control_targets
    @control_targets ||= []
  end
end
