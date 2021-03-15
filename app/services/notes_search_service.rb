# frozen_string_literal: true

class NotesSearchService
  def self.search(curr_notes, query)
    notes_ids = Rails.cache.fetch("notes_search/#{query}", expires_in: 1.hours) do
      curr_notes.where("title like '%#{query}%' ").map(&:id)
    end

    curr_notes.where(id: notes_ids)
  end

  def self.search_by_user(curr_notes,query)
    author = User.find_by discord_id: "#{query}"
    if author
      notes_ids = Rails.cache.fetch("notes_search/#{query}", expires_in: 1.hours) do
        curr_notes.where(user_id: author.id).map(&:id)
      end
    end
    curr_notes.where(id: notes_ids)
  end
end
