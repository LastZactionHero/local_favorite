class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauth_providers => [:twitter]

  has_one :user_plan
  has_many :locations
  has_many :search_terms
  has_many :tweets
  has_many :favorites
  
  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

  def to_s
    username || email
  end

end
