class AgentsController < ApplicationController
  def index
    @agents = Agent.all
  end

  def search
    @agents = Agent.search(params[:q])

    render action: :index
  end
end
