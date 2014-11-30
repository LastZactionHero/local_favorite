require 'spec_helper'

describe FollowersSearcher do

  describe 'find' do
  
    let(:user){
      FactoryGirl.create(:user, 
        twitter_access_token: "17945327-Lrurr7VSs55cbvl2deUylKV0sEzcakhHUsbdrJOiK", 
        twitter_access_token_secret: "fwrg9EHfudcpItz8waEXkdKBKVyxiZ1kUxJWyMu5s58VV")
    }
    let(:favorited){["alexbrackin2", "TeePolish", "ChristyDaleS"]}

    before(:each) do      
      favorited.each do |favorited|
        t = FactoryGirl.create(:tweet, tweet_id: favorited, user_id: user.id, data: {user: {screen_name: favorited}}.to_s)
        FactoryGirl.create(:favorite, selection: "automatic", tweet: t, user: user)
      end
    end

    it 'finds new followers that have also been favorited' do
      followers = nil
      VCR.use_cassette('followers_searcher') do
        followers = FollowersSearcher.find!(user)
      end

      expect(followers.length).to eq(favorited.length)
      expect(user.favorited_followers.length).to eq(favorited.length)      
      expect(ActionMailer::Base.deliveries.length).to eq(1)
    end

    it 'does not send a new follower email if the user already had followers' do
      FactoryGirl.create(:favorited_follower, screen_name: "someone", user: user)
      user.reload

      followers = nil
      VCR.use_cassette('followers_searcher') do
        followers = FollowersSearcher.find!(user)
      end

      expect(ActionMailer::Base.deliveries.length).to eq(0)
    end

    it 'does not add the same user twice' do
      followers = nil
      VCR.use_cassette('followers_searcher') do
        FollowersSearcher.find!(user)
      end

      # Play it again
      VCR.use_cassette('followers_searcher') do
        FollowersSearcher.find!(user)
      end

      expect(user.favorited_followers.length).to eq(favorited.length)
    end
  end

end