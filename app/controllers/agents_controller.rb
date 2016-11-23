# frozen_string_literal: true
class AgentsController < ApplicationController
  def index
    @agents = Agent.order(name: :ASC).all
  end

  def search
    @agents = Agent.search(params[:q])

    render action: :index
  end
end
