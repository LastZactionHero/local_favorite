require 'spec_helper'
include Devise::TestHelpers

describe BlacklistUsersController do
  render_views

  let(:user){FactoryGirl.create(:user)}

  before(:each) do
    Warden.test_mode!      
    warden.set_user(user)
  end

  after(:each) do
     Warden.test_reset!
   end

  describe 'index' do

    it 'displays a list of blacklisted users' do
      FactoryGirl.create(:blacklist_user, username: "someone_1", user_id: user.id)
      FactoryGirl.create(:blacklist_user, username: "someone_2", user_id: user.id)
      FactoryGirl.create(:blacklist_user, username: "someone_3", user_id: user.id)

      get :index
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body).to eq(["someone_1", "someone_2", "someone_3"])
    end

  end

  describe 'create' do

    it 'creates a blacklist user' do
      post :create, username: "someone"
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body).to eq({"username" => "someone"})

      expect(BlacklistUser.count).to eq(1)
      bu = BlacklistUser.first
      expect(bu.username).to eq("someone")
    end

    it 'fails to create a blacklist user if already created' do
      FactoryGirl.create(:blacklist_user, username: "someone", user_id: user.id)
      post :create, username: "someone"
      expect(response.status).to eq(400)
      body = JSON.parse(response.body)
      expect(body).to eq({"errors" => {"username" => ["has already been taken"]}})
    end

    it 'fails to create a blacklist user without a username' do
      FactoryGirl.create(:blacklist_user, username: "someone", user_id: user.id)
      post :create
      expect(response.status).to eq(400)
      body = JSON.parse(response.body)
      expect(body).to eq({"errors" => {"username" => ["can't be blank"]}})
    end

  end

  describe 'destroy' do

    it 'destroys a blacklisted user' do
      bu = FactoryGirl.create(:blacklist_user, username: "someone", user_id: user.id)
      delete :destroy, id: bu.username
      expect(response.status).to eq(200)

      expect(BlacklistUser.count).to eq(0)
    end

    it 'fails to destroy a blacklisted user that is not found' do
      delete :destroy, id: "someone"
      expect(response.status).to eq(404)
    end

  end

end