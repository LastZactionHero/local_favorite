class Tweet < ActiveRecord::Base
  belongs_to :search_term
  belongs_to :user
  has_one :favorite, dependent: :destroy

  validates_presence_of :tweet_id
  validates_uniqueness_of :tweet_id, scope: :user_id

  def data
    eval(self[:data])
  end

  def text
    data[:text]
  end

  def user
    TweetUser.new(data[:user])
  end

  def created_at
    DateTime.parse(data[:created_at])
  end

  def favorited?
    favorite.present?
  end

  def auto_favorited?
    favorited? && favorite.automatic?
  end

end
