require 'rails_helper'

RSpec.feature "ScenarioImport", type: :feature do
  fixtures :scenarios
  fixtures :users
  fixtures :agents

  before do
    @scenario = scenarios(:bob_weather)
    @scenario.update_attributes!(data: load_json_data('spec/data/diagram-test.json'))
  end

  it 'renders the diagram for complex scenarios' do
    visit scenario_path(@scenario)
    expect(page).to have_content('configures')
    expect(page).to have_content('runs')
  end
end
