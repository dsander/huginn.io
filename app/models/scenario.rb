class Scenario < ApplicationRecord
  belongs_to :user

  before_validation do
    self.data = JSON.parse(data) rescue data
  end

  validates :name, :data, presence: true
  validates_with ScenarioJson
end
