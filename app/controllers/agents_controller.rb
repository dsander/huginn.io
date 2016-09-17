class AgentsController < ApplicationController
  def index
    @agents = Agent.all
  end

  def show
    @agent = Agent.find(params[:id])
  end
end
