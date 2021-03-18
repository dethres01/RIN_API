# frozen_string_literal: true

class FundamentalUserChanges < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :user_type, :string
    add_column :users, :server_id, :string
  end
end
