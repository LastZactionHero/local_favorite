class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates_presence_of :tweet_id
  validates_presence_of :selection
  validates :selection, inclusion: { :in => ["manual", "automatic"] }

  scope :favorited_since, ->(time) {where("created_at > ?", time)}

  DAILY_FAVORITE_LIMIT = 400

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
    rescue Twitter::Error::Forbidden => e
      false
    rescue Twitter::Error::TooManyRequests => e
      false
    rescue Exception => e
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

  def self.below_daily_limit?(user)
    today_count = Favorite.where(user: user).favorited_since(1.day.ago).count
    today_count < DAILY_FAVORITE_LIMIT
  end

end
