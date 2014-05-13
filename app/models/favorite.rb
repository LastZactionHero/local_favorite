class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates_presence_of :selection
  validates :selection, inclusion: { :in => ["manual", "automatic"] }

  def favorite!
    begin
      client = TwitterRestClient.construct(user)
      client.favorite!(tweet.tweet_id)
      true
    rescue Twitter::Error::AlreadyFavorited => e
      false
    end
  end

  def unfavorite!
    client = TwitterRestClient.construct(user)
    client.unfavorite(tweet.tweet_id)
    true
  end

  def automatic?
    selection == "automatic"
  end
end
