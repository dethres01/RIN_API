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
class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :server_id,:discord_id
end
