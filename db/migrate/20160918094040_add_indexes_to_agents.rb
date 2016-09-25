class AddIndexesToAgents < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def up
    execute("CREATE INDEX CONCURRENTLY agents_name_idx ON agents USING gin(name gin_trgm_ops);")
    execute("CREATE INDEX CONCURRENTLY agents_description_idx ON agents USING gin(description gin_trgm_ops);")
  end

  def down
    execute("DROP INDEX agents_name_idx")
    execute("DROP INDEX agents_description_idx")
  end
end
