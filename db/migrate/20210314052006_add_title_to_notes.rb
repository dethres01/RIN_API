# frozen_string_literal: true

class AddTitleToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :title, :string
  end
end
