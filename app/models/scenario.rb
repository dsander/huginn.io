class Scenario < ApplicationRecord
  belongs_to :user

  serialize :data, JSON

  validates :name, presence: true
  validate :agents_json_valid?

  protected

  def agents_json_valid?
    if self.data == nil
      errors.add(:data, message: "can't be blank")
      return false
    end
    begin
      JSON.parse(self.data)
      return true
    rescue JSON::ParserError
      errors.add(:data, message: "not in JSON format")
    end
  end
end
