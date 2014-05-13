class DashboardController < ApplicationController
  authorize_resource class: false

  def index
    @search_terms = current_user.search_terms
    @tweets = current_user.tweets.order("id DESC").limit(100)
  end

end
