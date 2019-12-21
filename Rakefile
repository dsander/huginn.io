# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

begin
  require 'rspec/core/rake_task'
  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
  # no rspec available
end
