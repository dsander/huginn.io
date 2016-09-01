class Scenario < ApplicationRecord
  belongs_to :user

  serialize :data, JSON

  validates :name, :data, presence: true
  validate :agents_json_valid?

  protected

  def agents_json_valid?
    begin
      JSON.parse(self.data) unless self.data.blank?
      return true
    rescue JSON::ParserError
      errors.add(:data, message: "not in JSON format")
    end
  end
end
