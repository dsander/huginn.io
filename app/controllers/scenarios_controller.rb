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

  # GET /scenarios/new
  def new
    @scenario = current_user.scenarios.build
  end

  # GET /scenarios/1/edit
  def edit
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = current_user.scenarios.build(scenario_params)

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to @scenario, notice: 'Scenario was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /scenarios/1
  # PATCH/PUT /scenarios/1.json
  def update
    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to @scenario, notice: 'Scenario was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to scenarios_url, notice: 'Scenario was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scenario
      @scenario = current_user.scenarios.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scenario_params
      params.require(:scenario).permit(:name, :description, :data)
    end
end
