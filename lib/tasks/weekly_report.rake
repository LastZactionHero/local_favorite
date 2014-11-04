desc "Weekly Report"
task :weekly_report => :environment do

  User.where(weekly_updates: true).each do |user|
    if user.search_terms.any? && user.email.present?
      WeeklyReportMailer.weekly_report(user.id).deliver
    end
  end

end
