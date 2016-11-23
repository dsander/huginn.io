# frozen_string_literal: true
class WelcomeController < ApplicationController
  def index
    render text: '', layout: true
  end
end
