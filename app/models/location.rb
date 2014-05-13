class Location < ActiveRecord::Base
  # latitude, longitude, name, radius, user_id
  belongs_to :user
  has_many :search_terms

  validates_presence_of :name, :latitude, :longitude

  def to_s
    name
  end

  def radius
    self[:radius] || 5
  end

  def radius_unit
    "km"
  end

end
