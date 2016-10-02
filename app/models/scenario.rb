class Scenario < ApplicationRecord
  belongs_to :user

  validates :name, :data, presence: true
  validate :scenario_json_valid?

  protected

  def scenario_json_valid?
    begin
      self.data = JSON.parse(data) unless data.blank?
      return true if validate_data_hash && validate_scenario && validate_scenario_agents_array && validate_agents_hash && validate_scenario_agents
    rescue JSON::ParserError
      errors.add(:data, "not in JSON format")
    end
  end

  def validate_data_hash
    errors.add(:base, "data is not a JSON object.") unless data.is_a?(Hash)
    errors.empty?
  end

  def validate_scenario
    errors.add(:base, "The provided data does not appear to be a valid Scenario.") if (%w[name guid agents] - data.keys).length > 0
    errors.empty?
  end

  def validate_scenario_agents_array
    errors.add(:base, "data[\"agents\"] is not an array") unless data["agents"].is_a?(Array)
    error.empty?
  end

  def validate_agents_hash
    errors.add(:base, "data[\"agents\"] elements must be JSON objects") unless data["agents"].any?{ |a| a.is_a?(Hash) }
    errors.empty?
  end

  def validate_scenario_agents
    data["agents"].each do |agent|
      errors.add(:base, "The Scenario contains invalid agents.") if agent["name"].blank? || agent["type"].blank?
    end
  end
end
