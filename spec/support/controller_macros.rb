# frozen_string_literal: true
module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in users(:bob)
    end
  end
end
