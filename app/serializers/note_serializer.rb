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
class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author
  def author
    user =self.object.user
    {
      discord_id: user.discord_id,
      server_id: user.server_id,
      id: user.id 
    }
  end
end
