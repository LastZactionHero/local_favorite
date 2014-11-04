class WeeklyReportController < ApplicationController
  before_filter :find_user_by_token

  layout "landing"

  def unsubscribe
    @successful = false
    if @user
      @user.unsubscribe_weekly_reports!
      @successful = true
    end
  end

  private

  def find_user_by_token
    unsubscribe_token = params.delete(:unsubscribe_token)
    if unsubscribe_token
      @user = User.find_by_unsubscribe_token(unsubscribe_token)
    end
  end

end
