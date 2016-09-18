class AgentGemsController < ApplicationController
  def index
    @agent_gems = AgentGem.all
  end
end
