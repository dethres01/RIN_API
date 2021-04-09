# frozen_string_literal: true

class NotesSearchService
  def self.search(curr_notes, query)
    notes_ids = Rails.cache.fetch("notes_search/#{query}", expires_in: 1.hours) do
      curr_notes.where("title like '%#{query}%' ").map(&:id)
      #N+1 query
    end

    curr_notes.where(id: notes_ids)
  end

  # locate
  def self.search_by_user(curr_notes, query)
    notes_ids = Rails.cache.fetch("notes_search/#{query}", expires_in: 1.hours) do
      curr_notes.where(discord_id: query).map(&:id)
    end
    curr_notes.where(id: notes_ids)
  end

  # find
  def self.search_by_server(curr_notes, query)
    notes_ids = Rails.cache.fetch("notes_search/#{query}", expires_in: 1.hours) do
      curr_notes.where(server_id: query).map(&:id)
    end
    curr_notes.where(id: notes_ids)
  end
end
