require 'rails_helper'

describe Scenario do
  fixtures :users
  let(:new_instance) { users(:bob).scenarios.build(name: "some scenario", data: "{}") }

  describe "validations" do
    before do
      expect(new_instance).to be_valid
    end

    it "validates the presence of name" do
      new_instance.name = ''
      expect(new_instance).not_to be_valid
    end

    it "validates the presence of user" do
      new_instance.user = nil
      expect(new_instance).not_to be_valid
    end

    it "validates presence of data attribute " do
      new_instance.data = nil
      expect(new_instance).not_to be_valid
    end

    it "validates data is json" do
      new_instance.data = JSON.dump({test: :hubs})
      expect(new_instance).to be_valid
    end

    it "invalidates if data is not json " do
      new_instance.data = '{\"test":\"hubs\"}'
      expect(new_instance).not_to be_valid
    end
  end
end
