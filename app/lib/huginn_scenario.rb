# frozen_string_literal: true

class HuginnScenario
  attr_reader :agents, :data

  def initialize(data)
    @data = data
    @agents = data['agents'].map { |a| HuginnAgent.new(a) }
    compute_links
  end

  def compute_links
    data['links'].each do |link|
      @agents.at(link['source']).receivers << @agents.at(link['receiver'])
    end
    data['control_links'].each do |link|
      @agents.at(link['controller']).control_targets << @agents.at(link['control_target'])
    end
  end
end
