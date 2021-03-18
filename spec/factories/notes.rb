# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#
FactoryBot.define do
  factory :note do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    association :user, factory: :user
  end
end
