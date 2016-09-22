require 'rails_helper'
require 'agent_gem_fetcher'

RSpec.describe AgentGemFetcher, type: :model do

  it 'parses a gemspec file' do
    # Code search for .gemspec files
    stub_request(:get, "https://api.github.com/search/code?q=huginn%20extension:gemspec").
      with(:headers => {'Accept'=>'application/vnd.github.v3+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Octokit Ruby Gem 4.3.0'}).
      to_return(:status => 200, :body => File.read(File.join(Rails.root, 'spec/data/github_gemspec_search.json')), :headers => {'Content-Type'=>'application/json'})
    # Download .gemspec
    stub_request(:get, "https://raw.githubusercontent.com/kreuzwerker/DKT.huginn_freme_enrichment_agents/0462b2b73547e5a06eb6527c8a8361e1d87d740e//huginn_freme_enrichment_agents.gemspec").
       with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
       to_return(:status => 200, :body => File.read(File.join(Rails.root, 'spec/data/huginn_freme_enrichment_agents.gemspec')), :headers => {})
    # Get repository information
    stub_request(:get, "https://api.github.com/repositories/67696115").
       with(:headers => {'Accept'=>'application/vnd.github.v3+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Octokit Ruby Gem 4.3.0'}).
       to_return(:status => 200, :body => File.read(File.join(Rails.root, 'spec/data/github_repository_get.json')), :headers => {'Content-Type'=>'application/json'})
    data = AgentGemFetcher.run
    expect(data).to match_array([{name: "huginn_freme_enrichment_agents",
                                  version: "0.1",
                                  summary: "Agents for doing natural language processing using the FREME APIs.",
                                  description: "Write a longer description or delete this line.",
                                  license: "Apache License 2.0",
                                  repository: "kreuzwerker/DKT.huginn_freme_enrichment_agents",
                                  stars: 0,
                                  watchers: 0}])
  end
end
