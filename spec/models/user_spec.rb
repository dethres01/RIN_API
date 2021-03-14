# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  discord_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_type  :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Model Validations' do
    it 'should have the proper structure' do
      should have_db_column('id')
      should have_db_column('discord_id')
      should have_db_column('user_type')
      should have_db_column('created_at')
      should have_db_column('updated_at')
    end
    it 'should have many notes' do
      should have_many('notes')
    end
    it 'should have the proper validations' do
      should validate_presence_of('discord_id')
      should validate_presence_of('user_type')
      should validate_length_of('discord_id')
      # Since discord_id is only numbers,we have to specify that our
      # validation doesn't care about alphacharacters
      should validate_uniqueness_of('discord_id').case_insensitive
    end
  end
end
