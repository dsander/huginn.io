# frozen_string_literal: true
require 'rails_helper'

RSpec.feature "Agents", type: :feature do
  fixtures :agents

  context '#index' do
    it 'shows all agents' do
      visit agents_path
      expect(page).to have_text('Website Agent Creates events Receives events Dry runs Form configurable')
      expect(page).to have_text('A meaningful description')
    end
  end

  context '#search', js: true do
    it 'only shows the found agents' do
      visit agents_path
      fill_in 'q', with: 'website'
      find('input[name=q]').native.send_keys(:return)
      expect(page).to have_text('Website Agent Creates events Receives events Dry runs Form configurable')
      expect(page).not_to have_text('Hipchat')
    end
  end
end
