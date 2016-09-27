class AddAttributesToScenarios < ActiveRecord::Migration[5.0]
  def change
    add_column :scenarios, :tag_bg_color, :string
    add_column :scenarios, :tag_fg_color, :string
    add_column :scenarios, :icon, :string
  end
end
