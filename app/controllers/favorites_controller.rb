class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.create(
      user_id: current_user.id,
      tweet_id: params[:tweet_id],
      selection: "manual")
    @favorite.favorite!
    render status: 200, json: {}
  end

  def unfavorite
    tweet = Tweet.find(params[:tweet_id])
    
    @favorite = tweet.favorite
    @favorite.unfavorite!

    @favorite.destroy

    render status: 200, json: {}
  end
end
