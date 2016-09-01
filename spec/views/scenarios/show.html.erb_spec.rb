require 'rails_helper'

RSpec.describe "scenarios/show", type: :view do
  before(:each) do
    @scenario = assign(:scenario, Scenario.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
