class AddAttributesToScenarios < ActiveRecord::Migration[5.0]
  def change
    add_column :scenarios, :guid, :string
  end
end
