class ScenarioJson < ActiveModel::Validator
  def validate(record)
    record.errors.add(:data, "not in JSON format") unless options[:data_is_json]
    return true if options[:data_is_json] && validate_data_hash(record) && validate_scenario(record) && validate_scenario_agents_array(record) && validate_agents_hash(record) && validate_scenario_agents(record)
  end

  def validate_data_hash(record)
    record.errors.add(:base, "data is not a JSON object.") unless record.data.is_a?(Hash)
    record.errors.empty?
  end

  def validate_scenario(record)
    record.errors.add(:base, "The provided data does not appear to be a valid Scenario.") if (%w[name guid agents] - record.data.keys).length > 0
    record.errors.empty?
  end

  def validate_scenario_agents_array(record)
    record.errors.add(:base, "The agents of a scenario need to be stored in a JSON array") unless record.data["agents"].is_a?(Array)
    record.errors.empty?
  end

  def validate_agents_hash(record)
    record.errors.add(:base, "An agent of a scenario need to be stored as a JSON objects") unless record.data["agents"].any?{ |a| a.is_a?(Hash) }
    record.errors.empty?
  end

  def validate_scenario_agents(record)
    record.data["agents"].each do |agent|
      next if agent["name"].present? && agent["type"].present?
      record.errors.add(:base, "The Scenario contains invalid agents.")
      break
    end
  end
end
