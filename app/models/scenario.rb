class Scenario < ApplicationRecord
  belongs_to :user

  validates :name, :data, presence: true
  validate :agents_json_valid?

  protected

  def agents_json_valid?
    begin
      self.data = JSON.parse(data) unless data.blank?
      return true
    rescue JSON::ParserError
      errors.add(:data, "not in JSON format")
    end
  end
end
