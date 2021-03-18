class MergeUserandNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :discord_id, :string
    add_column :notes, :server_id, :string
  end
end
