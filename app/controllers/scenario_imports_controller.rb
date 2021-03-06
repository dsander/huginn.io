# frozen_string_literal: true

class ScenarioImportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @scenario_import = ScenarioImport.new(url: params[:url])
  end

  def create
    @scenario_import = ScenarioImport.new(scenario_import_params)
    @scenario_import.user = current_user

    if @scenario_import.valid? && @scenario_import.import_confirmed? && @scenario_import.import
      redirect_to @scenario_import.scenario, notice: "Import successful!"
    else
      render action: "new"
    end
  end

  private

  def scenario_import_params
    params.require(:scenario_import).permit(:url, :data, :file, :do_import)
  end
end
