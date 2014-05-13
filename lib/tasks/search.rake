namespace :search do

  desc "Search for SearchTerms"
  task :search => :environment do
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

      puts "Still Here"
      tweets = user_tweets[:tweets]
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
