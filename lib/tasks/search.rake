namespace :search do

  desc "Search for SearchTerms"
  task :search => :environment do
    begin
      find_and_favorite
    rescue Exception => e
      ExceptionMailer.exception_email(e, nil).deliver
    end
  end

  task :find_followers => :environment do
    User.all.each do |user|
      FollowersSearcher.find!(user)
    end
  end

  def find_and_favorite
    auto_favorites_per_term = 3

    new_tweets = []

    # Find Tweets
    SearchTerm.all.each do |term|
      tweets = term.search!
      puts "Found these tweets: #{tweets}"
      new_tweets << {user: term.user, tweets: tweets}
    end

    # Favorite Them
    new_tweets.each do |user_tweets|
      "New Tweets for User"
      user = user_tweets[:user]
      next unless user.automatic_favoriting?
      next unless Favorite.below_daily_limit?(user)

      puts "Still Here"
      tweets = user_tweets[:tweets]

      tweets.delete_if{|t| user.blacklisted_user?(t.user.screen_name)}
      
      tweets.sample(auto_favorites_per_term).each do |favorite_tweet|
        puts "Favoriting this tweet: #{favorite_tweet.id}"

        @favorite = Favorite.create(
          user_id: user.id,
          tweet_id: favorite_tweet.id,
          selection: "automatic")
        @favorite.favorite!
      end
    end
  end

end
