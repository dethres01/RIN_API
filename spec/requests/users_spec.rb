# frozen_string_literal: true

require 'rails_helper'
# since this one is a personal project I'll do extra comments to understand
# what I'm doing
RSpec.describe '/users', type: :request do
  let!(:valid_user) { create(:user) }
  let(:valid_user1) { create(:user) }
  let!(:valid_params) { { 'user' => { 'discord_id' => '123123123456456456', 'server_id' => '123456789123456789' } } }
  let!(:invalid_params) { { 'user' => { 'discord_id' => '23123123456456456', 'server_id' => '123456789123456789' } } }
  # here we create a let!, meaning, it creates when it's defined
  # here we create with let, mening, it only creates when we call it
  describe 'GET /users' do
    # to make these kind of test work we need information in our database
    # we could either seed our db or just create an user beforehand with let!
    before { get '/users' } # we access get /users
    it 'should return OK' do
      payload = JSON.parse(response.body) # get the payload to parse it
      expect(payload).not_to be_empty # since there's content in the index
      # we want it to NOT be empty
      expect(response).to have_http_status(200)
      # we don't have any kind of authorization so it should return OK regardless
    end
  end

  describe 'GET /users/{:id}' do
    # we want to access an specific id
    # when we do that in rails, we call the Class#show action
    # we should try the next events:
    # the element exists and it can be accesed
    # the element doesn't exist and we should raise an exception
    it 'should look at an existing user and return it' do
      get "/users/#{valid_user.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(valid_user.id)
      expect(payload['discord_id']).to eq(valid_user.discord_id)
      expect(payload['server_id']).to eq(valid_user.server_id)
      expect(response).to have_http_status(200)
    end
    it "should raise an exception because user doesn't exist" do
      get '/users/1234'
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /users' do
    # this is the way I'm going to register users
    # discord_ids are uniq, so if a user with the same id tries to register
    # again it should return an exception
    # Also, we could test to register an invalid user, that should return another exception
    # I don't know if they're the same exception but les go
    it 'creates an user' do
      post '/users/', params: valid_params
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload).to include('discord_id', 'server_id')
      expect(response).to have_http_status(:created)
    end
    it 'raises an exception if we try to create an existing user' do
      post '/users/', params: valid_params
      payload = JSON.parse(response.body)
      expect(payload).to include('discord_id', 'server_id')
      expect(response).to have_http_status(:created)
      post '/users/', params: valid_params
      payload = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'raises an exception if user is invalid' do
      post '/users/', params: invalid_params
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload).to include('error')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe 'PUT /users/{:id}' do
    # atm there's no need to update an user once it's created since it cannot change
    # from user to server or change his userid
  end
end
