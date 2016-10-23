class AddUrlToScenario < ActiveRecord::Migration[5.0]
  def change
    add_column :scenarios, :url, :string
  end
end
