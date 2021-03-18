# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  discord_id :string
#  server_id  :string
#
require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'Model Validation' do
    it 'should have the proper columns' do
      should have_db_column('id')
      should have_db_column('title')
      should have_db_column('discord_id')
      should have_db_column('server_id')
      should have_db_column('body')
      should have_db_column('created_at')
      should have_db_column('updated_at')
    end
    it 'should have the proper validations' do
      should validate_presence_of('body')
      should validate_presence_of('title')
      should validate_presence_of('discord_id')
      should validate_length_of('body')
      should validate_length_of('discord_id')
      should validate_length_of('server_id')
    end
  end
end
