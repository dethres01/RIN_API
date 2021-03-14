require 'rails_helper'

RSpec.describe "/users", type: :request do
  let!(:valid_user) {create(:user,:user_t)}
  let(:invalid_user) {create :user,user_type: "nobueno"}
  describe "GET /users" do

    before { get '/users' }
    it "should return OK" do
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/{:id}" do
    before {get "/users/#{valid_user.id}"}
    it "should creat an user" do
      
      
    end

  end
end