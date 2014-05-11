class SearchTerm < ActiveRecord::Base
  # term, user_id
  belongs_to :user

  def to_s
    term
  end
end
