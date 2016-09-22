require 'rails_helper'
require 'agent_importer'

RSpec.describe AgentImporter, type: :model do
  it 'imports Agent Gems from a valid JSON file' do
    data = JSON.parse(File.read(File.join(Rails.root, 'spec/data/agents.json')))
    expect {
      AgentImporter.run(data)
    }.to change(AgentGem, :count).by(1)
    gem = AgentGem.last
    expect(gem.summary).to eq('Agents for doing natural language processing using the FREME APIs.')
    expect(gem.description).to eq('Write a longer description or delete this line.')
    expect(gem.license).to eq('Apache License 2.0')
    expect(gem.name).to eq('huginn_freme_enrichment_agents')
    expect(gem.repository).to eq('kreuzwerker/DKT.huginn_freme_enrichment_agents')
    expect(gem.stars).to eq(0)
    expect(gem.version).to eq('0.2')
    expect(gem.watchers).to eq(0)
  end

  it 'imports Agents from a valid JSON file' do
    data = JSON.parse(File.read(File.join(Rails.root, 'spec/data/agents.json')))
    expect {
      AgentImporter.run(data)
    }.to change(Agent, :count).by(71)
  end
end
