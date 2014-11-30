class FollowersSearcher

  class << self

    def find!(user)      
      begin
        client = TwitterRestClient.construct(user)
        followers = client.followers
      rescue Twitter::Error::Unauthorized => e
        return []
      rescue Twitter::Error::RequestTimeout => e
        return []
      end

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

      added_through_favoriting.map do |screen_name|
        FavoritedFollower.create(screen_name: screen_name, user: user)
      end
    end

  end

  private

end
