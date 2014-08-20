namespace :cleanup do

  desc "Remove all tweets and favorites older than 30 days"
  task :remove_older_than_30_days => :environment do
    last_date = 30.days.ago
    Favorite.where("created_at < ?", 30.day.ago).delete_all
    Tweet.where("created_at < ?", 30.days.ago).delete_all
  end

end
