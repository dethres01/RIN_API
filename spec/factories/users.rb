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
FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    name {Faker::Name.name}
  end
end
