require 'rails_helper'

RSpec.feature "ScenarioImport", type: :feature do
  fixtures :users
  fixtures :scenarios
  before do
    login_as(users(:bob))
  end

  def upload_scenario_json
    visit new_scenario_import_path
    attach_file('Option 2: Upload a Scenario JSON File', File.join(Rails.root, 'spec/data/ifttt-roundtrip-scenario.json'))
    click_on 'Start Import'
    expect(page).to have_text('To use this scenario you need to connect to the')
    expect(page).not_to have_text('This Scenario already exists in your system.')
    check('I confirm that I want to upload this Scenario.')
    expect {
      click_on 'Finish Import'
    }.to change(Scenario, :count).by(1)
  end

  it 'renders the upload form' do
    visit new_scenario_import_path
    expect(page).to have_text('Add a Scenario to Huginn.io')
  end

  it 'requires a URL or file uplaod' do
    visit new_scenario_import_path
    click_on 'Start Import'
    expect(page).to have_text('Please provide either a Scenario JSON File or a Public Scenario URL.')
  end

  it 'does not allow to upload an invalid scenario' do
    visit new_scenario_import_path
    attach_file('Option 2: Upload a Scenario JSON File', File.join(Rails.root, 'spec/data/agents.json'))
    click_on 'Start Import'
    expect(page).to have_text('Please provide either a Scenario JSON File or a Public Scenario URL.')
  end

  context 'creating new scenarios' do
    it 'allows to upload a new scenario' do
      upload_scenario_json
      expect(page).to have_text('Import successful!')
    end

    it 'allows to create a scenario using an URL' do
      stub_request(:get, "http://example.com/scenario.json").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => File.open(File.join(Rails.root, 'spec/data/ifttt-roundtrip-scenario.json')).read, :headers => {})
      visit new_scenario_import_path
      fill_in('Option 1: Provide a Public Scenario URL', with: 'http://example.com/scenario.json')
      click_on 'Start Import'
      check('I confirm that I want to upload this Scenario.')
      expect {
        click_on 'Finish Import'
      }.to change(Scenario, :count).by(1)
    end
  end

  context 'updating existing scenarios' do
    it 'shows the changed options', js: true do
      upload_scenario_json
      visit new_scenario_import_path
      attach_file('Option 2: Upload a Scenario JSON File', File.join(Rails.root, 'spec/data/ifttt-roundtrip-changed-scenario.json'))
      click_on 'Start Import'
      expect(page).to have_text('v10')
      expect(page).to have_text('This Scenario already exists in Huginn.io')
      expect(page).to have_text('Name changed from IFTTT Trigger to IFTTT Trigger (Updated)')
      expect(page).to have_text('Schedule changed from never to 6h')
      expect(page).to have_text('Keep Events For changed from 0 to 3600')
      expect(page).to have_text('Propagate Immediately changed from false to true')
      expect(page).to have_text('Disabled changed from false to true')
      check('I confirm that I want to upload this Scenario.')
      expect {
        click_on 'Finish Import'
      }.to change(Scenario, :count).by(0)
      expect(page).to have_text('Import successful!')
    end
  end
end
