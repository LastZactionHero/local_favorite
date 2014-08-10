class DashboardController < ApplicationController
  authorize_resource class: false
  before_filter :validate_email
  before_filter :find_search_term

  def index
    @favorites = current_user.favorites.where("created_at > ?", 1.day.ago).
      order("created_at DESC")

    @tweets = find_tweets(@selected_search_term)
  end

  private

  def find_search_term
    @search_terms = current_user.search_terms

    search_term_id = params.delete(:search_term_id)
    @selected_search_term = search_term_id ?
      SearchTerm.find(search_term_id) : nil
  end

  def find_tweets(search_term)
    root = search_term ? search_term : current_user
    root.tweets.where("created_at > ?", 1.day.ago).
      order("created_at DESC")
  end

  def validate_email
    unless current_user.email.present?
      flash[:notice] = "Please enter your email address"
      redirect_to profile_index_path
    end
  end


end
