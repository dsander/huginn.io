require 'rails_helper'

RSpec.describe AgentGemsController, type: :controller do

  describe "GET #index" do
    fixtures :agent_gems

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:agent_gems)).to eq(AgentGem.all)
    end
  end
end
