# frozen_string_literal: true

class NoteDeleteService
  def self.auth(curr_note, query)
    curr_note.discord_id == query
  end
end
