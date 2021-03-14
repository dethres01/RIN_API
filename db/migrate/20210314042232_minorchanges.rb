# frozen_string_literal: true

class Minorchanges < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :server_type, :user_type
  end
end
