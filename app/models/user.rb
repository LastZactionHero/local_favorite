class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable,
         :omniauth_providers => [:twitter]

  has_one :user_plan
  has_many :locations
  has_many :search_terms
  has_many :tweets
  has_many :favorites

  validates_presence_of :unsubscribe_token
  before_validation :set_unsubscribe_token

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

  def to_s
    username || email
  end

  def set_automatic_favoriting!(enabled)
    self.automatic_favoriting = enabled
    self.save
  end

  def plan
    user_plan ? user_plan.plan : DefaultPlan.new
  end

  def can_add_more_search_terms?
    search_terms.count < plan.max_search_terms
  end

  def unsubscribe_weekly_reports!
    self.weekly_updates = false
    self.save
  end

  private

  def set_unsubscribe_token
    self.unsubscribe_token ||= SecureRandom.hex(10)
  end
end
