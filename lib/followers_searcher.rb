class FollowersSearcher

  class << self

    def find!(user)
      had_no_followers = user.favorited_followers.empty?

      begin
        client = TwitterRestClient.construct(user)
        followers = client.followers

        usernames = []
        followers.each do |follower|
          usernames << follower.username
        end
      rescue Twitter::Error::Unauthorized => e
        return []
      rescue Twitter::Error::TooManyRequests => e
        return []
      rescue Twitter::Error::RequestTimeout => e
        return []
      rescue Twitter::Error::Forbidden => e
        return []
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

        if had_no_followers
          had_no_followers = false
          first_favorite_message(user, screen_name)
        end
      end
    end

    private

    def first_favorite_message(user, screen_name)
      WeeklyReportMailer.first_follower(user, screen_name).deliver
    end

  end
end
