module DotHelper
  def render_agents_diagram(agents, layout: nil)
    svg = IO.popen(['dot', *%w(-Tsvg -q1 -o/dev/stdout /dev/stdin)], 'w+') do |dot|
      dot.print agents_dot(agents, rich: true, layout: layout)
      dot.close_write
      dot.read
    end
    svg.html_safe
  end

  class DotDrawer
    def initialize(vars = {})
      @dot = ''
      @vars = vars.symbolize_keys
    end

    def method_missing(var, *args)
      @vars.fetch(var) { super }
    end

    def to_s
      @dot
    end

    def self.draw(*args, &block)
      drawer = new(*args)
      drawer.instance_exec(&block)
      drawer.to_s
    end

    def raw(string)
      @dot << string
    end

    ENDL = ';'.freeze

    def endl
      @dot << ENDL
    end

    def escape(string)
      # Backslash escaping seems to work for the backslash itself,
      # though it's not documented in the DOT language docs.
      string.gsub(/[\\"\n]/,
                  "\\" => "\\\\",
                  "\"" => "\\\"",
                  "\n" => "\\n")
    end

    def id(value)
      case string = value.to_s
      when /\A(?!\d)\w+\z/, /\A(?:\.\d+|\d+(?:\.\d*)?)\z/
        raw string
      else
        raw '"'
        raw escape(string)
        raw '"'
      end
    end

    def ids(values)
      values.each_with_index do |id, i|
        raw ' ' if i > 0
        id id
      end
    end

    def attr_list(attrs = nil)
      return if attrs.nil?
      attrs = attrs.select { |_key, value| value.present? }
      return if attrs.empty?
      raw '['
      attrs.each_with_index do |(key, value), i|
        raw ',' if i > 0
        id key
        raw '='
        id value
      end
      raw ']'
    end

    def node(id, attrs = nil)
      id id
      attr_list attrs
      endl
    end

    def edge(from, to, attrs = nil, op = '->')
      id from
      raw op
      id to
      attr_list attrs
      endl
    end

    def statement(ids, attrs = nil)
      ids Array(ids)
      attr_list attrs
      endl
    end

    def block(*ids)
      ids ids
      raw '{'
      yield
      raw '}'
    end
  end

  private

  def draw(vars = {}, &block)
    DotDrawer.draw(vars, &block)
  end

  def agents_dot(agents, rich: false, layout: nil)
    draw(agents: agents,
         agent_id: ->(agent) { 'a%d' % agent.id },
         agent_label: lambda do |agent|
           agent.name.gsub(/(.{20}\S*)\s+/) do
             # Fold after every 20+ characters
             Regexp.last_match(1) + "\n"
           end
         end,
         agent_url: ->(agent) { "##{agent.guid}" },
         rich: rich) do
      @disabled = '#999999'

      def agent_node(agent)
        node(agent_id[agent],
             label: agent_label[agent],
             tooltip: (agent.short_type.titleize if rich),
             URL: (agent_url[agent] if rich),
             style: ('rounded,dashed' if agent.unavailable?),
             color: (@disabled if agent.unavailable?),
             fontcolor: (@disabled if agent.unavailable?))
      end

      def agent_edge(agent, receiver)
        edge(agent_id[agent],
             agent_id[receiver],
             style: ('dashed' unless receiver.propagate_immediately?),
             label: (" #{agent.control_action}s " if agent.can_control_other_agents?),
             arrowhead: ('empty' if agent.can_control_other_agents?),
             color: (@disabled if agent.unavailable? || receiver.unavailable?))
      end

      block('digraph', 'Agent Event Flow') do
        layout ||= ENV['DIAGRAM_DEFAULT_LAYOUT'].presence
        if rich && /\A[a-z]+\z/ === layout
          statement 'graph', layout: layout, overlap: 'false'
        end
        statement 'node',
                  shape: 'box',
                  style: 'rounded',
                  fontsize: 10,
                  fontname: ('Helvetica' if rich)

        statement 'edge',
                  fontsize: 10,
                  fontname: ('Helvetica' if rich)

        agents.each.with_index do |agent, _index|
          agent_node(agent)

          [
            *agent.receivers,
            *(agent.control_targets if agent.can_control_other_agents?)
          ].each do |receiver|
            agent_edge(agent, receiver) if agents.include?(receiver)
          end
        end
      end
    end
  end
end
