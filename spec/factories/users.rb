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
    discord_id {18.times.map { rand(10) }.join.to_s}
    trait :user_t do
      user_type {"user"}
    end
    trait :server_t do
      user_type {"server"}
    end
  end
end
