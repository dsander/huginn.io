# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huginn_lifx_agents/version'

Gem::Specification.new do |spec|
  spec.name          = "huginn_lifx_agents"
  spec.version       = HuginnLifxAgents::VERSION
  spec.authors       = ["Will Read"]
  spec.email         = ["will.read@omniscope.io"]

  spec.summary       = "Huginn agents to interact with your LIFX light blubs"
  spec.description   = "Huginn agents to interact with your LIFX light blubs"
  spec.homepage      = "https://huginn.omniscope.io/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "huginn_agent", "~> 0.4.0"
  spec.add_runtime_dependency "omniauth-lifx", "~> 1.1.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
