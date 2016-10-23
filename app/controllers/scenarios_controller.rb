class ScenariosController < ApplicationController
  before_action :set_scenario, only: [:show, :edit, :update, :destroy]

  # GET /scenarios
  # GET /scenarios.json
  def index
    @scenarios = current_user.scenarios.all
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to scenarios_url, notice: 'Scenario was successfully destroyed.' }
    end
  end

  def search
    @scenarios = Scenario.search(params[:q])

    render action: :index
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scenario
    @scenario = current_user.scenarios.find(params[:id])
  end
end
