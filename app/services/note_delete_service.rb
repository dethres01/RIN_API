class NoteDeleteService
  def self.auth(curr_note,query)
    if curr_note.discord_id == query
      return true
    else
      return false
    end
  end
end