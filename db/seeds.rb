# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

require 'agent_importer'
require 'agent_fetcher'
require 'open-uri'

if ENV['AGENT_JSON']
  data = JSON.parse(open(ENV['AGENT_JSON']).read)
  AgentImporter.run(data)
else
  data = AgentFetcher.run
  File.open('agents.json', 'w').write(JSON.dump(data))
  AgentImporter.run(data.map(&:stringify_keys))
end
