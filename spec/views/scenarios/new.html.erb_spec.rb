require 'rails_helper'

RSpec.describe "scenarios/new", type: :view do
  before(:each) do
    assign(:scenario, Scenario.new())
  end

  it "renders new scenario form" do
    render

    assert_select "form[action=?][method=?]", scenarios_path, "post" do
    end
  end
end
