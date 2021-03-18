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
FactoryBot.define do
  factory :user do
    discord_id { 18.times.map { rand(10) }.join.to_s }
    server_id { 18.times.map { rand(10) }.join.to_s }
  end
end
