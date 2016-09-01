require 'rails_helper'

RSpec.describe "scenarios/edit", type: :view do
  before(:each) do
    @scenario = assign(:scenario, Scenario.create!())
  end

  it "renders the edit scenario form" do
    render

    assert_select "form[action=?][method=?]", scenario_path(@scenario), "post" do
    end
  end
end
