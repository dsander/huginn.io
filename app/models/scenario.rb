class Scenario < ApplicationRecord
  belongs_to :user

  validates :name, :data, presence: true
  validate :valid_scenario

  def valid_scenario
    begin
      self.data = JSON.parse(data) unless data.blank?
      validates_with ScenarioJson, data_is_json: true
    rescue JSON::ParserError
      validates_with ScenarioJson, data_is_json: false
    end
  end
end
