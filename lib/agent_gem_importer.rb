require 'open-uri'
require 'gemspec_parser'

class AgentGemImporter
  def self.run
    files = client.search_code('huginn extension:gemspec')
    files[:items].each do |file|
      data = check_gemspec(file)
      next unless data

      repo = client.repository(file.repository.id)
      data = data.merge!(repository: repo.full_name, stars: repo.stargazers_count, watchers: repo.watchers_count)
      data.delete(:description) if data[:summary] == data[:description]

      agent_gem = AgentGem.find_or_initialize_by(repository: repo.full_name)
      agent_gem.update_attributes!(data)
    end
  end

  private

  def self.client
    Octokit::Client.new(:access_token => ENV['GITHUB_API_KEY'])
  end

  def self.check_gemspec(file)
    download_url = file.html_url.sub('github.com', 'raw.githubusercontent.com').sub('/blob', '')
    return unless file.path.end_with?('.gemspec')
    gemspec = GemspecParser.parse(open(download_url).read)
    return unless gemspec[:add_runtime_dependency]
    return unless gemspec[:add_runtime_dependency].include?('huginn_agent')
    gemspec.slice(:name, :version, :summary, :description, :license)
  end
end
