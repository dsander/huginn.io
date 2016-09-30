class Scenario < ApplicationRecord
  belongs_to :user

  validates :name, :data, presence: true
  validate :agents_json_valid?

  protected

  def agents_json_valid?
    begin
      self.data = JSON.parse(data) unless data.blank?
      validate_scenario
      validate_scenario_agents
    rescue JSON::ParserError
      errors.add(:data, "not in JSON format")
    end
  end

  def validate_scenario
    errors.add(:base, "The provided data does not appear to be a valid Scenario.") if (%w[name guid agents] - data.keys).length > 0
  end

  def validate_scenario_agents
    data["agents"].to_a.each do |agent|
      errors.add(:base, "The Scenario contains invalid agents.") if agent["name"].blank? || agent["type"].blank?
    end
  end
end
