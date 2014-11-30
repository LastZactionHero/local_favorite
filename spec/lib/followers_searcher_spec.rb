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


# "alexbrackin2",
#  "TeePolish",
#  "AntonioParis",
#  "hnshah",
#  "tripleitalent",
#  "dinyrabo",
#  "ThreadlessNews",
#  "JoshOiknine",
#  "ChristyDaleS",
#  "_ashleighmiller"