# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AgentsController, type: :controller do
  fixtures :agents

  describe "GET #index" do
    it "assigns all agents" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:agents)).to match_array(Agent.all)
    end
  end

  describe "GET #search" do
    it "searches for agents" do
      get :search, params: {q: 'website'}
      expect(response).to have_http_status(:success)
      expect(assigns(:agents)).to match_array([agents(:website_agent)])
    end
  end
end
