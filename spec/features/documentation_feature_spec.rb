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

    it 'redirects to the index if the requested template does not exist' do
      visit documentation_path('nope')
      expect(page.current_path).to eq(documentation_index_path)
    end
  end
end
