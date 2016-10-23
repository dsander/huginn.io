require 'open-uri'
require 'gemspec_parser'

class AgentGemFetcher
  class <<self
    def run
      files = client.search_code('huginn extension:gemspec')
      files[:items].map do |file|
        data = check_gemspec(file)
        next unless data

        repo = client.repository(file.repository.id)
        data.delete(:description) if data[:summary] == data[:description]
        data.merge!(repository: repo.full_name, stars: repo.stargazers_count, watchers: repo.watchers_count)
      end.compact
    end

    private

    def client
      Octokit::Client.new(access_token: ENV['GITHUB_API_KEY'])
    end

    def check_gemspec(file)
      download_url = file.html_url.sub('github.com', 'raw.githubusercontent.com').sub('/blob', '')
      return unless file.path.end_with?('.gemspec')
      gemspec = GemspecParser.parse(open(download_url).read)
      return unless gemspec[:add_runtime_dependency]
      return unless gemspec[:add_runtime_dependency].include?('huginn_agent')
      gemspec.slice(:name, :version, :summary, :description, :license)
    end
  end
end
