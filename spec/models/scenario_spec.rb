require 'rails_helper'

describe Scenario do
  fixtures :users
  let(:new_instance) { users(:bob).scenarios.build(name: "some scenario", data: {"name" => "testscenario", "guid" => "someguid", "agents" => [{"name" => "testagent", "type" => "testtype"}]}) }

  describe "validations" do
    before do
      expect(new_instance).to be_valid
    end

    it "validates the presence of name" do
      new_instance.name = ''
      new_instance.data = HashWithIndifferentAccess.new(name: "testscenario", guid: "someguid", agents: [{name: "testagent", type: "testtype" }])
      expect(new_instance).not_to be_valid
    end

    it "validates the presence of user" do
      new_instance.user = nil
      new_instance.data = HashWithIndifferentAccess.new(name: "testscenario", guid: "someguid", agents: [{name: "testagent", type: "testtype" }])
      expect(new_instance).not_to be_valid
    end

    it "validates presence of data attribute " do
      new_instance.data = nil
      expect(new_instance).not_to be_valid
    end

    it "validates data is json" do
      new_instance.data = HashWithIndifferentAccess.new(name: "testscenario", guid: "someguid", agents: [{name: "testagent", type: "testtype" }])
      expect(new_instance).to be_valid
    end

    it "validates data is a JSON Object " do
      new_instance.data = []
      expect(new_instance).not_to be_valid
    end

    it "validates data is a valid Scenario " do
      new_instance.data = HashWithIndifferentAccess.new(agents: [{name: "testagent", type: "testtype" }])
      expect(new_instance).not_to be_valid
    end

    it "validates data['agents'] is an array" do
      new_instance.data = HashWithIndifferentAccess.new(name: "testscenario", guid: "someguid", agents: "test")
      expect(new_instance).not_to be_valid
    end

    it "validates data['agents'] array contains JSON objects" do
      new_instance.data = HashWithIndifferentAccess.new(name: "testscenario", guid: "someguid", agents: ["test"])
      expect(new_instance).not_to be_valid
    end

    it "validates data['agents'] array contains valid agents" do
      new_instance.data = HashWithIndifferentAccess.new(name: "testscenario", guid: "someguid", agents: [{name: "testagent"}])
      expect(new_instance).not_to be_valid
    end

    it "invalidates if data is not json " do
      new_instance.data = '{\"test":\"hubs\"}'
      expect(new_instance).not_to be_valid
    end
  end
end
