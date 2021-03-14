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
class User < ApplicationRecord
  has_many :notes

  validates :discord_id, presence: true, length: { is: 18 }, uniqueness: { case_sensitive: false }
  validates :user_type, presence: true, inclusion: { in: %w[user server] }
end
