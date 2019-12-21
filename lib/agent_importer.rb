# frozen_string_literal: true

class AgentImporter
  class <<self
    def run(data)
      Agent.transaction do
        Agent.destroy_all
        data.each do |agent_gem|
          gem = update_agent_gem(agent_gem)
          agent_gem['agents'].each do |agent|
            Agent.create!(agent.merge(agent_gem: gem))
          end
        end
      end
    end

    private

    def update_agent_gem(agent_gem)
      return unless agent_gem['repository']

      AgentGem.find_or_initialize_by(repository: agent_gem['repository']).tap do |gem|
        gem.update!(agent_gem.except('agents'))
      end
    end
  end
end
