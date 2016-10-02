class Scenario < ApplicationRecord
  belongs_to :user

  before_validation do
    self.data = JSON.parse(data) rescue data
  end

  validates :name, :data, presence: true
  validates_with ScenarioJson

  def self.search(term)
    where('name ILIKE ? OR description ILIKE ?', "%#{term}%", "%#{term}%")
  end

  [:tag_fg_color, :tag_bg_color, :icon].each do |method|
    define_method(method) do
      (data || {})[method.to_s]
    end
  end

  def get_agent_data(guid)
    data['agents'].select { |a| a['guid'] == guid }.first
  end

  protected

  def self.icons
    @icons ||= begin
      YAML.load_file(Rails.root.join('config/icons.yml'))
    end
  end

end
