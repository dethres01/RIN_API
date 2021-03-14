# frozen_string_literal: true

class RemoveNameAndEmailfromUser < ActiveRecord::Migration[6.1]
  def change
    # remove_column :table_name, :column_name
    remove_column :users, :name, :string
    remove_column :users, :email, :string
  end
end
