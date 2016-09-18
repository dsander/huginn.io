class CreateAgentGems < ActiveRecord::Migration[5.0]
  def change
    create_table :agent_gems do |t|
      t.string :name
      t.string :summary
      t.string :description
      t.string :repository
      t.string :version
      t.string :license
      t.integer :stars
      t.integer :watchers

      t.timestamps
    end
  end
end
