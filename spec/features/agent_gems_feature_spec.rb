# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "AgentGems", type: :feature do
  fixtures :all

  context '#index' do
    it 'shows all agent gems' do
      visit agent_gems_path
      expect(page).to have_text('huginn_freme_enrichment_agents')
    end
  end
end
