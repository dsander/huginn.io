class Agent < ApplicationRecord
  def self.search(term)
    where('name ILIKE ? OR description ILIKE ?', "%#{term}%", "%#{term}%")
  end
end
