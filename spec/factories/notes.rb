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
FactoryBot.define do
  factory :note do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    discord_id {10.times.map{rand(10)}.join}
    server_id {10.times.map{rand(10)}.join}
  end
end
