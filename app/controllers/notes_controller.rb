# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[show update destroy]

  # GET /notes
  def index
    @notes = Note.all
    @notes = NotesSearchService.search(@notes, params[:search]) if !params[:search].nil? && params[:search].present?
    if !params[:locate].nil? && params[:locate].present?
      @notes = NotesSearchService.search_by_user(@notes,
                                                 params[:locate])
    end
    @notes = NotesSearchService.search_by_server(@notes, params[:find]) if !params[:find].nil? && params[:find].present?
    render json: @notes, status: :ok
  end

  # GET /notes/1
  def show
    render json: @note
  end

  # POST /notes
  def create
    @note = Note.new(note_params)

    if @note.save
      render json: @note, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.discord_id == note_params['discord_id']
      if @note.update(note_params)
        render json: @note
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # DELETE /notes/1
  def destroy
    @validation = NoteDeleteService.auth(@note, params[:auth]) if !params[:auth].nil? && params[:auth].present?
    if @validation
      @note.destroy
      render json: { api: 'Succesfully deleted' }, status: 201
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:title, :body, :discord_id, :server_id)
  end
end
