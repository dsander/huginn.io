require 'rails_helper'

RSpec.describe "scenarios/index", type: :view do
  before(:each) do
    assign(:scenarios, [
      Scenario.create!(),
      Scenario.create!()
    ])
  end

  it "renders a list of scenarios" do
    render
  end
end
