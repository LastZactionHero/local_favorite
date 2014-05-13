class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.create(user_id: current_user.id, tweet_id: params[:tweet_id])
    @favorite.favorite!
    render status: 200, json: {}
  end

end
