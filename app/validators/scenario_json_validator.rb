# frozen_string_literal: true

class ScenarioJsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    data = record.send(attribute)
    return record.errors.add(:base, "Please provide either a Scenario JSON File or a Public Scenario URL.") if !data.is_a?(Hash) || data.empty?

    validate_scenario(record, data) &&
      validate_scenario_agents_array(record, data) &&
      validate_agents_hash(record, data) &&
      validate_scenario_agents(record, data)
  end

  def validate_scenario(record, data)
    record.errors.add(:base, "The provided data does not appear to be a valid Scenario.") unless (%w[name guid agents] - data.keys).empty?
    record.errors.empty?
  end

  def validate_scenario_agents_array(record, data)
    record.errors.add(:base, "The agents of a scenario need to be stored in a JSON array") unless data["agents"].is_a?(Array)
    record.errors.empty?
  end

  def validate_agents_hash(record, data)
    record.errors.add(:base, "An agent of a scenario need to be stored as a JSON objects") unless data["agents"].any? { |a| a.is_a?(Hash) }
    record.errors.empty?
  end

  def validate_scenario_agents(record, data)
    data["agents"].each do |agent|
      next if agent["name"].present? && agent["type"].present?

      record.errors.add(:base, "The Scenario contains invalid agents.")
      break
    end
  end
end
