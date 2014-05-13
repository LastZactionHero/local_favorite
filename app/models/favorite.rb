class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates_presence_of :selection
  validates :selection, inclusion: { :in => ["manual", "automatic"] }

  def favorite!
    client = TwitterRestClient.construct(user)
    client.favorite!(tweet.tweet_id)
  end
end
