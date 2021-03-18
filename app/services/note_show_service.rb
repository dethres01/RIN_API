# frozen_string_literal: true

class NoteShowService
  def self.auth(curr_note, query)
    curr_note.server_id == query
  end
end
