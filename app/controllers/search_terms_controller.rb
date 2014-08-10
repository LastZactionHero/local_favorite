class SearchTermsController < ApplicationController
  before_filter :find_search_term, only: [:edit, :update, :destroy]
  before_filter :find_locations, only: [:new, :edit, :update, :create]
  def index
    @search_terms = current_user.search_terms
  end

  def new
    @search_term = SearchTerm.new
  end

  def edit

  end

  def update
    search_term = params[:search_term]
    address = search_term.delete(:location)
    radius = search_term.delete(:radius).to_i

    if address
      location = find_or_build_location(address, radius)
      search_term[:location_id] = location.id if location
    end

    @search_term.update_attributes({
      keywords: search_term[:keywords],
      location_id: search_term[:location_id],
      user: current_user})

    if @search_term.errors.any?
      render :edit
    else
      @search_term.search!
      flash[:notice] = "Search term updated."

      if current_user.search_terms.count > 1
        redirect_to search_terms_path
      else
        redirect_to dashboard_path
      end
    end

  end

  def create
    unless current_user.can_add_more_search_terms?
      flash[:alert] = "You have added your maximum number of search terms for this plan."
      redirect_to search_terms_path and return
    end

    search_term = params[:search_term]
    address = search_term.delete(:location)
    radius = search_term.delete(:radius)

    if address && search_term[:location_id].blank?
      location = find_or_build_location(address, radius)
      search_term[:location_id] = location.id if location
    end

    @search_term = SearchTerm.create(keywords: search_term[:keywords],
      location_id: search_term[:location_id],
      user: current_user)

    if @search_term.errors.any?
      render :new
    else
      flash[:notice] = "Search term added."

      if current_user.search_terms.count > 1
        redirect_to search_terms_path
      else
        redirect_to dashboard_path
      end
    end
  end

  def destroy
    @search_term = SearchTerm.find(params[:id])
    @search_term.destroy

    flash[:notice] = "Search term deleted."
    redirect_to search_terms_path
  end

  private

  def find_or_build_location(address, radius)
    location = Location.where(user_id: current_user.id).find_by_name_and_radius(address, radius)
    return location if location

    searcher = GeoSearcher.new(address, Geocoder)
    begin
      result = searcher.search!
      location = Location.create(
        latitude: result.latitude,
        longitude: result.longitude,
        name: address,
        radius: radius,
        user: current_user)
    rescue GeoSearchNoResultsException => e
    end
    location
  end

  def find_search_term
    @search_term = SearchTerm.find(params[:id])
  end

  def find_locations
    @locations = current_user.locations
  end

end
