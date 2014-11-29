class BlacklistUser < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :username
  validates_presence_of :user_id
  validates_uniqueness_of :username, scope: :user_id
end
