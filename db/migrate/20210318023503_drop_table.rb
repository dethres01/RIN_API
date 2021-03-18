class DropTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :notes, :user_id
    drop_table :users
  end
end
