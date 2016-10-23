require 'ostruct'

# This is a helper class for managing Scenario imports, used by the ScenarioImportsController.  This class behaves much
# like a normal ActiveRecord object, with validations and callbacks.  However, it is never persisted to the database.
class ScenarioImport
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations::Callbacks

  URL_REGEX = /\Ahttps?:\/\//i

  attr_accessor :file, :url, :data, :do_import, :merges, :user

  before_validation :parse_file
  before_validation :fetch_url

  validates_format_of :url, with: URL_REGEX, allow_nil: true, allow_blank: true, message: "appears to be invalid"
  validates :parsed_data, scenario_json: true

  after_validation do
    if errors.present?
      self.data = nil
      @parsed_data = nil
    end
  end

  def step_one?
    data.blank?
  end

  def step_two?
    data.present?
  end

  def existing_scenario
    @existing_scenario ||= user.scenarios.find_by(guid: parsed_data["guid"])
  end

  def parsed_data
    @parsed_data ||= (begin
                        data && JSON.parse(data)
                      rescue
                        {}
                      end) || {}
  end

  def agent_diffs
    @agent_diffs || generate_diff
  end

  def import_confirmed?
    do_import == "1"
  end

  def import(_options = {})
    success = true
    guid        = parsed_data['guid']
    description = parsed_data['description']
    name        = parsed_data['name']
    @scenario = user.scenarios.where(guid: guid).first_or_initialize
    @scenario.update_attributes!(name: name, description: description, data: parsed_data)

    success
  end

  def scenario
    @scenario || @existing_scenario
  end

  protected

  def parse_file
    return if data.present? || file.blank?
    self.data = file.read.force_encoding(Encoding::UTF_8)
  end

  def fetch_url
    return if data.present? || url.blank? || url !~ URL_REGEX
    self.data = Faraday.get(url).body
  end

  def generate_diff
    @agent_diffs = (parsed_data['agents'] || []).map.with_index do |agent_data, _index|
      # AgentDiff is defined at the end of this file.
      agent_diff = AgentDiff.new(agent_data)
      if existing_scenario
        # If this Agent exists already, update the AgentDiff with the local version's information.
        agent_diff.diff_with! existing_scenario.get_agent_data(agent_data['guid'])
      end
      agent_diff
    end
  end

  # AgentDiff is a helper object that encapsulates an incoming Agent.  All fields will be returned as an array
  # of either one or two values.  The first value is the incoming value, the second is the existing value, if
  # it differs from the incoming value.
  class AgentDiff < OpenStruct
    class FieldDiff
      attr_accessor :incoming, :updated
      attr_reader :current

      def initialize(incoming)
        @incoming = incoming
        @updated = incoming
      end

      def current=(current)
        @current = current
        @requires_merge = (incoming != current)
      end

      def requires_merge?
        @requires_merge
      end
    end

    def initialize(agent_data)
      super()
      @requires_merge = false
      self.agent = nil
      store! agent_data
    end

    BASE_FIELDS = %w(name schedule keep_events_for propagate_immediately disabled guid).freeze

    def agent_exists?
      agent.present?
    end

    def requires_merge?
      @requires_merge
    end

    def store!(agent_data)
      self.type = FieldDiff.new(agent_data["type"].split("::").pop)
      self.options = FieldDiff.new(agent_data['options'] || {})
      BASE_FIELDS.each do |option|
        if agent_data.key?(option)
          value = agent_data[option]
          self[option] = FieldDiff.new(value)
        end
      end
    end

    def diff_with!(agent)
      return unless agent.present?

      self.agent = agent

      type.current = agent['type'].gsub(/^.*::/, '')
      options.current = agent['options'] || {}

      @requires_merge ||= type.requires_merge?
      @requires_merge ||= options.requires_merge?

      BASE_FIELDS.each do |field|
        next unless self[field].present?
        self[field].current = agent.send(:[], field.to_s)

        @requires_merge ||= self[field].requires_merge?
      end
    end

    def each_field
      yield 'name', self['name'] if self['name'].requires_merge?
      yield 'schedule', self['schedule'] if self['schedule'].present? && (!agent_exists? || self['schedule'].requires_merge?)
      yield 'keep_events_for', self['keep_events_for'] if self['keep_events_for'].present? && (!agent_exists? || self['keep_events_for'].requires_merge?)
      yield 'propagate_immediately', self['propagate_immediately'] if self['propagate_immediately'].present? && (!agent_exists? || self['propagate_immediately'].requires_merge?)
      yield 'disabled', self['disabled'] if !agent_exists? || self['disabled'].requires_merge?
    end
  end
end
