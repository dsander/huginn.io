# frozen_string_literal: true
class AgentGemsController < ApplicationController
  def index
    @agent_gems = AgentGem.all
  end
end
