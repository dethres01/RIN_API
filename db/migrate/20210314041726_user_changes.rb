class UserChanges < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :auth_token, :discord_id
    add_column :users, :server_type, :string
  end
end
