# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookController, type: :controller do
  before { ENV['API_TOKEN'] = 'very_secret' }
  describe "POST import_agents" do
    it "returns 403 when the token does not match" do
      post :import_agents, params: { token: 'false' }
      expect(response).to have_http_status(:forbidden)
    end

    it "calls the AgentImporter with the received data" do
      expect(AgentImporter).to receive(:run).with(ActionController::Parameters.new(some: 'data').permit!)
      post :import_agents, params: { token: 'very_secret', data: { some: 'data' } }
      expect(response).to have_http_status(:success)
    end
  end
end
