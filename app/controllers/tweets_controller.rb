class TweetsController < ApplicationController

  def index
    @search_terms = current_user.search_terms
    @tweets = current_user.tweets.order("created_at DESC").limit(100)
  end

end
