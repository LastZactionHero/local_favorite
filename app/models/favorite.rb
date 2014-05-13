class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  def favorite!
    client = TwitterRestClient.construct(user)
    client.favorite!(tweet.tweet_id)
  end
end
