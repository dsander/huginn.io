class CreateScenarios < ActiveRecord::Migration[5.0]
  def change
    create_table :scenarios do |t|
      t.text :description
      t.string :name
      t.json :data
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
