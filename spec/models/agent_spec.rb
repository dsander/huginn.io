require 'rails_helper'

RSpec.describe Agent, type: :model do
  fixtures :agents

  context 'Agent.search' do
    it 'finds agents when searching for a word' do
      agents = Agent.search('website')
      expect(agents).to match_array([agents(:website_agent)])
    end

    it 'finds agents when search for part of a workd' do
      agents = Agent.search('chat')
      expect(agents).to match_array([agents(:hipchat_agent)])
    end
  end
end
