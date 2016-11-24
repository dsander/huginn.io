# frozen_string_literal: true
class Agent < ApplicationRecord
  belongs_to :agent_gem, optional: true

  def self.search(term)
    where('name ILIKE ? OR description ILIKE ?', "%#{term}%", "%#{term}%")
  end
end
