require 'rails_helper'
require 'agent_gem_importer'

RSpec.describe AgentGemImporter, type: :model do

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
    expect {
      AgentGemImporter.run
    }.to change(AgentGem, :count).by(1)
    gem = AgentGem.first
    expect(gem.summary).to eq('Agents for doing natural language processing using the FREME APIs.')
    expect(gem.description).to eq('Write a longer description or delete this line.')
    expect(gem.license).to eq('Apache License 2.0')
    expect(gem.name).to eq('huginn_freme_enrichment_agents')
    expect(gem.repository).to eq('kreuzwerker/DKT.huginn_freme_enrichment_agents')
    expect(gem.stars).to eq(0)
    expect(gem.version).to eq('0.1')
    expect(gem.watchers).to eq(0)
  end
end
