class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates_presence_of :tweet_id
  validates_presence_of :selection
  validates :selection, inclusion: { :in => ["manual", "automatic"] }

  def favorite!
    return false unless tweet

    begin
      client = TwitterRestClient.construct(user)
      client.favorite!(tweet.tweet_id)
      true
    rescue Twitter::Error::NotFound => e
      false
    rescue Twitter::Error::AlreadyFavorited => e
      false
    rescue Twitter::Error::Unauthorized => e
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
