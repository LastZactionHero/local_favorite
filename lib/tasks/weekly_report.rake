desc "Weekly Report"
task :weekly_report => :environment do

  User.where("email IS NOT NULL").where(weekly_updates: true).each do |user|
    if user.search_terms.any?
      WeeklyReportMailer.weekly_report(user.id).deliver
    end
  end

end
