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
class Note < ApplicationRecord
  validates :body, presence: true, length: { minimum: 15 }
  validates :title, presence: true
  validates :discord_id, presence: true, length: {is: 18}
  validates :server_id,presence: true, length: {is: 18}
end
