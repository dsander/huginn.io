require 'agent_gem_fetcher'

# :nocov:
# This will very likely change to a script that is automatically ran in a CI environment
# and post the agents to the real communing instance.
class AgentFetcher
  class <<self
    def run(gem_data = AgentGemFetcher.run)
      without_side_effects do
        `echo "\\nADDITIONAL_GEMS=" >> ../huginn/.env`
        huginn_agents = load_agents
        huginn_agent_names = huginn_agents.map { |agent| agent['name'] }

        gem_data.map do |gem_data|
          `echo "\\nADDITIONAL_GEMS=#{gem_data[:name]}(github: #{gem_data[:repository]})" >> ../huginn/.env`
          `cd ../huginn && bundle install`
          gem_agents = load_agents.reject { |agent| huginn_agent_names.include?(agent['name']) }
          gem_data[:agents] = gem_agents
          gem_data
        end.push({agents: huginn_agents })
      end
    end

    private

    def without_side_effects
      Bundler.with_clean_env do
        FileUtils.cp('../huginn/.env', '../huginn/.env.bak')
        yield
      end
    end

    def load_agents
      JSON.parse(`cd ../huginn && RAILS_ENV=production bundle exec rails runner #{Rails.root}/lib/extract_huginn_agents_script.rbx`)
    end
  end
end
