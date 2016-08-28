class AddOmniAuthAttributesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :provider_uid, :string
    add_column :users, :nickname, :string
    add_column :users, :name, :string
    add_column :users, :avatar, :string
  end
end
