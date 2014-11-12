require 'spec_helper'

describe WeeklyReportMailer do

  describe 'weekly_report' do
    let(:user){FactoryGirl.create(:user)}
    let(:search_term){FactoryGirl.create(:search_term, user: user)}

    it 'indicates the number of favorites and tweets found this week' do
      user.automatic_favoriting = true
      user.save

      tweets = (0..51).map do |i|
        FactoryGirl.create(:tweet,
                            user: user,
                            search_term: search_term,
                            tweet_id: "tweet_#{i}")
      end
      tweets.first(5).each do |tweet|
        FactoryGirl.create(:favorite, 
                           tweet: tweet, 
                           user: user, 
                           selection: "automatic")
      end

      mail = WeeklyReportMailer.weekly_report(user.id)
      expect(mail.body).to include("Favorites this Week: 5")
      expect(mail.body).to include("Found Tweets this Week: 52")
      expect(mail.body).not_to include("We did not find many result")
      expect(mail.body).not_to include("If you're happy with the tweets")
    end

    it 'displays a message if too few results are found' do
      user.automatic_favoriting = true
      user.save

      tweets = (0..5).map do |i|
        FactoryGirl.create(:tweet,
                            user: user,
                            search_term: search_term,
                            tweet_id: "tweet_#{i}")
      end

      mail = WeeklyReportMailer.weekly_report(user.id)
      expect(mail.body).to include("We did not find many result")
    end

    it 'displays a message if automatic favoriting is off' do
      user.automatic_favoriting = false
      user.save
      
      tweets = (0..5).map do |i|
        FactoryGirl.create(:tweet,
                            user: user,
                            search_term: search_term,
                            tweet_id: "tweet_#{i}")
      end

      mail = WeeklyReportMailer.weekly_report(user.id)
      expect(mail.body).to include("If you're happy with the tweets")
    end

  end
end
