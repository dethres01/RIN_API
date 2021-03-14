class NotesSearchService
  def self.search(curr_notes,query)
    #
    notes_ids=Rails.cache.fetch("notes_search/#{query}", expires_in: 1.hours) do
      curr_notes.where("title like '%#{query}%' ").map(&:id)
    end

    curr_notes.where(id: notes_ids)
  end
end