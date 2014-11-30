client = TwitterRestClient.construct(user)

followers = c.followers

usernames = []
followers.each do |follower|
  usernames << follower.username
end

added_through_favoriting = []

favorited_since = 1.week.ago
favorites = user.favorites.where("created_at > ?", favorited_since)
favorites.each do |favorite|
  favorited_user = favorite.tweet.user.screen_name
  if usernames.include?(favorited_user)
    added_through_favoriting << favorited_user
  end
end

