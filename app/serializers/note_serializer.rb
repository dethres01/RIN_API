class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author
  def author
    user =self.object.user
    {
      discord_id: user.discord_id,
      user_type: user.user_type,
      id: user.id 
    }
  end
end
