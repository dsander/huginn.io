class CreateAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :agents do |t|
      t.string :name
      t.text :description
      t.boolean :creates_events
      t.boolean :receives_events
      t.boolean :consumes_file_pointer
      t.boolean :emits_file_pointer
      t.boolean :controls_agents
      t.boolean :dry_runs
      t.boolean :form_configurable
      t.string :oauth_service

      t.timestamps
    end
  end
end
