# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  discord_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  server_id  :string
#
class User < ApplicationRecord
  has_many :notes

  validates :discord_id, presence: true, length: { is: 18 }, uniqueness: { case_sensitive: false }
  validates :server_id,presence: true, length: {is: 18}
end
