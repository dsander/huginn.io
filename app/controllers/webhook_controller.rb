# frozen_string_literal: true

require 'agent_importer'

class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_token

  def import_agents
    AgentImporter.run(params.permit![:data])

    head :ok
  end

  private

  def authenticate_token
    head :forbidden if params[:token] != ENV['API_TOKEN']
  end
end
