class WeeklyReportMailer < ActionMailer::Base
  default from: "zach@localfavorite.me"

  MIN_EXPECTED_RESULTS = 50

  def weekly_report(user_id)
    @user = User.find(user_id)
    @tweets = @user.tweets.where("created_at >= ?", 1.week.ago).length
    @favorites = @user.favorites.where("created_at >= ?", 1.week.ago).length
    @followers = @user.favorited_followers.where("created_at >= ?", 1.week.ago).length

    @low_results = @tweets < MIN_EXPECTED_RESULTS
    @auto_favoriting_disabled = !@user.automatic_favoriting

    mail(to: @user.email, subject: "Your Weekly Favorites Report")
  end

  def first_follower(user_id, screen_name)
    @user = User.find(user_id)
    @screen_name = screen_name
    mail(to: @user.email, subject: "Congrats on your first follower from LocalFavorite!")
  end

end
