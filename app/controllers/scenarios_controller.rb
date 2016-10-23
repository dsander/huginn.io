class ScenariosController < ApplicationController
  before_action :load_scenario, only: [:show, :download]

  # GET /scenarios
  # GET /scenarios.json
  def index
    @scenarios = Scenario.all
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario = current_user.scenarios.find(params[:id])
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to scenarios_url, notice: 'Scenario was successfully destroyed.' }
    end
  end

  def download
    send_data @scenario.data.to_json, filename: "#{@scenario.name}.json"
  end

  def search
    @scenarios = Scenario.search(params[:q])

    render action: :index
  end

  private

  def load_scenario
    @scenario = Scenario.find(params[:id])
  end
end
