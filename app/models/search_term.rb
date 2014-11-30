class SearchTerm < ActiveRecord::Base
  attr_accessor :radius

  # keywords, location_id, user_id
  
  belongs_to :location
  belongs_to :user
  has_many :tweets, dependent: :destroy

  validates_presence_of :keywords

  after_create :search!

  def search!
    return true if Rails.env.test?

    processor = TwitterSearchProcessor.new(self, user, TwitterSearcher, TwitterRestClient, Tweet)
    processor.process!
  end

  def to_s
    location ? "#{keywords} in #{location}" : keywords
  end

end
