class DashboardController < ApplicationController
  authorize_resource class: false

  def index
    @search_terms = current_user.search_terms
    @favorites = current_user.favorites.where("created_at > ?", 1.day.ago)
    @tweets = current_user.tweets.where("created_at > ?", 1.day.ago)
  end

end
