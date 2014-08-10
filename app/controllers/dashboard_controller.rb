class DashboardController < ApplicationController
  authorize_resource class: false
  before_filter :validate_email

  def index
    @search_terms = current_user.search_terms

    @favorites = current_user.favorites.where("created_at > ?", 1.day.ago).
      order("created_at DESC")

    @tweets = current_user.tweets.where("created_at > ?", 1.day.ago).
      order("created_at DESC")
  end

  private

  def validate_email
    unless current_user.email.present?
      flash[:notice] = "Please enter your email address"
      redirect_to profile_index_path
    end
  end


end
