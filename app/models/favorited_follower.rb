class FavoritedFollower < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :screen_name, scope: :user_id
end
