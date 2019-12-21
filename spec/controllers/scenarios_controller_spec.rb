# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScenariosController, type: :controller do
  fixtures :all
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Scenario. As you add validations to Scenario, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { user: users(:bob), name: "test", data: JSON.parse("{\"schema_version\":1,\"name\":\"test\",\"description\":\"No description provided\",\"guid\":\"2d99fa86351e84316c4797509579d46d\",\"agents\":[{\"type\":\"Agents::EventFormattingAgent\",\"name\":\"array test\"}]}") }
  }

  let(:invalid_attributes) {
    { user: users(:bob), name: "test", data: "{test: fail_json}" }
  }

  describe "GET #index" do
    it "assigns all scenarios as @scenarios" do
      scenario = Scenario.create! valid_attributes
      get :index, params: {}
      expect(assigns(:scenarios)).to include(scenarios(:bob_weather))
      expect(assigns(:scenarios)).to include(scenario)
    end
  end

  describe "GET #show" do
    it "assigns the requested scenario as @scenario" do
      scenario = Scenario.create! valid_attributes
      get :show, params: {id: scenario.to_param}
      expect(assigns(:scenario)).to eq(scenario)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested scenario" do
      scenario = Scenario.create! valid_attributes
      expect {
        delete :destroy, params: {id: scenario.to_param}
      }.to change(Scenario, :count).by(-1)
    end

    it "redirects to the scenarios list" do
      scenario = Scenario.create! valid_attributes
      delete :destroy, params: {id: scenario.to_param}
      expect(response).to redirect_to(scenarios_url)
    end
  end

  describe 'GET #download' do
    it 'sends to correct response headers for a file download' do
      scenario = Scenario.create! valid_attributes
      get :download, params: {id: scenario.to_param}
      expect(response.headers['Content-Type']).to eq('application/json')
      expect(response.headers['Content-Disposition']).to eq('attachment; filename="test.json"')
    end

    it 'sends to correct response headers for a file download' do
      scenario = Scenario.create! valid_attributes
      expect(@controller).to receive(:send_data).with(JSON.pretty_generate(scenario.data), filename: 'test.json') do
        @controller.head :ok
      end
      get :download, params: {id: scenario.to_param}
    end
  end
end
