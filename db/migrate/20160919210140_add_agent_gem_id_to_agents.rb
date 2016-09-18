class AddAgentGemIdToAgents < ActiveRecord::Migration[5.0]
  def change
    add_column :agents, :agent_gem_id, :integer
  end
end
