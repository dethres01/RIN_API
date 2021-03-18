# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/notes', type: :request do
  let!(:valid_params) do
    { 'note' => { 'title' => 'this is a valid param', 'body' => 'this is a valid body text',
                  'discord_id' => '111222333444555666', 'server_id' => '111222333444555666' } }
  end
  describe 'GET /notes' do
    let!(:array_of_notes) { create_list(:note, 10) }
    it 'should get the proper amount of posts' do
      get '/notes'
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload.size).to eq(10)
      expect(response).to have_http_status(200)
    end
  end
  describe 'search' do
    let!(:hola_mundo) { create(:note, title: 'Hola Mundo') }
    let!(:hola_rails) { create(:note, title: 'Hola Rails') }
    let!(:curso_rails) { create(:note, title: 'Curso Rails') }
    it 'should filter posts by title' do
      get '/notes?search=Hola'
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload.size).to eq(2)
      expect(payload.map { |p| p['id'] }.sort).to eq([hola_mundo.id, hola_rails.id])
      expect(response).to have_http_status(200)
    end
  end
  describe 'locate' do
    let!(:hola_mundo) { create(:note, discord_id: '123456789123456789') }
    let!(:hola_rails) { create(:note, discord_id: '123456789123456789') }
    let!(:curso_rails) { create(:note, discord_id: '123456789123456780') }
    it 'should filter posts by user' do
      get '/notes?locate=123456789123456789'
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload.size).to eq(2)
      expect(payload.map { |p| p['id'] }.sort).to eq([hola_mundo.id, hola_rails.id])
      expect(response).to have_http_status(200)
    end
  end

  describe 'find' do
    let!(:hola_mundo) { create(:note, server_id: '123456789123456789') }
    let!(:hola_rails) { create(:note, server_id: '123456789123456789') }
    let!(:curso_rails) { create(:note, server_id: '123456789123456780') }
    it 'should filter posts by user' do
      get '/notes?find=123456789123456789'
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload.size).to eq(2)
      expect(payload.map { |p| p['id'] }.sort).to eq([hola_mundo.id, hola_rails.id])
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /notes/{:id}' do
    let!(:valid_note) { create(:note) }
    it 'Should return the proper note' do
      get "/notes/#{valid_note.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(valid_note.id)
      expect(payload['title']).to eq(valid_note.title)
      expect(payload['body']).to eq(valid_note.body)
      expect(payload['discord_id']).to eq(valid_note.discord_id)
      expect(payload['server_id']).to eq(valid_note.server_id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /notes' do
    before { post '/notes', params: valid_params }
    context 'payload' do
      subject { payload }
      it { is_expected.to include(:id, :title, :body, :discord_id, :server_id) }
    end
    # response
    context 'response' do
      subject { response }
      it { is_expected.to have_http_status(:created) }
    end
  end

  describe 'PUT /notes/{:id}' do
    let!(:valid_note1) { create(:note) }
    context 'when updating another users note' do
      before { put "/notes/#{valid_note1.id}", params: valid_params }
      context 'payload' do
        subject { payload }
        it { is_expected.to include(:error) }
        # it { expect(payload[:id]).to eq(valid_note1.id)}
      end
      context 'response' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
      # updating other person's note
      # Also I have to think about permission
    end
  end
  describe 'DELETE /notes/{:id}' do
    let!(:delete_note) { create(:note) }
    it 'with valid auth' do
      delete "/notes/#{delete_note.id}?auth=#{delete_note.discord_id}"
      payload = JSON.parse(response.body)
      expect(response).to have_http_status(201)
    end
    it 'without valid auth' do
      delete "/notes/#{delete_note.id}"
      payload = JSON.parse(response.body)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  private

  def payload
    JSON.parse(response.body).with_indifferent_access
  end
end
