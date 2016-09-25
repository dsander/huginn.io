require 'rails_helper'
require 'gemspec_parser'

RSpec.describe GemspecParser, type: :model do
  let(:data) { File.read(File.join(Rails.root, 'spec/data/huginn_lifx_agents.gemspec')) }

  it 'parses a gemspec file' do
    gemspec = GemspecParser.parse(data)
    expect(gemspec).to eq({name: "huginn_lifx_agents",
                           summary: "Huginn agents to interact with your LIFX light blubs",
                           description: "Huginn agents to interact with your LIFX light blubs",
                           homepage: "https://huginn.omniscope.io/",
                           license: "MIT",
                           add_runtime_dependency: ["huginn_agent", "omniauth-lifx"],
                           add_development_dependency: ["bundler", "rake", "rspec"]})
  end
end
