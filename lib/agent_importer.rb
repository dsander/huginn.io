# :nocov:
# This will very likely change to a script that is automatically ran in a CI environment
# and post the agents to the real communing instance.
class AgentImporter

  class <<self
    def run
      without_side_effects do
        Agent.destroy_all

        `echo "\\nADDITIONAL_GEMS=" >> ../huginn/.env`
        huginn_agents = load_agents
        import(huginn_agents)
        huginn_agents.map! { |agent| agent['name'] }

        AgentGem.all.each do |agent_gem|
          `echo "\\nADDITIONAL_GEMS=#{agent_gem.name}(github: #{agent_gem.repository})" >> ../huginn/.env`
          `cd ../huginn && bundle install`
          gem_agents = load_agents.reject { |agent| huginn_agents.include?(agent['name']) }
          import(gem_agents, agent_gem)
        end
      end
    end

    private

    def without_side_effects
      Agent.transaction do
        Bundler.with_clean_env do
          FileUtils.cp('../huginn/.env', '../huginn/.env.bak')
          yield
        end
      end
    ensure
      FileUtils.mv('../huginn/.env.bak', '../huginn/.env')
    end

    def load_agents
      JSON.parse(`cd ../huginn && RAILS_ENV=production bundle exec rails runner #{Rails.root}/lib/extract_huginn_agents_script.rbx`)
    end

    def import(data, agent_gem = nil)
      data.each do |a|
        Agent.create!(a.merge(agent_gem: agent_gem))
      end
    end
  end
end
