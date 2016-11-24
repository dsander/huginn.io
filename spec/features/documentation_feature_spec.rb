# frozen_string_literal: true
require 'rails_helper'

RSpec.feature "Documentation", type: :feature do
  context '#index' do
    it 'shows the about page per default' do
      visit documentation_index_path
      expect(page).to have_text('What is Huginn?')
    end
  end
  context '#show' do
    it 'renders sub pages' do
      visit documentation_index_path
      click_on('Concepts')
      expect(page).to have_text('Lorem ipsum dolor sit amet')
    end
  end
end
