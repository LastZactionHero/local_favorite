class SearchTermsController < ApplicationController

  def index
    @search_terms = current_user.search_terms
  end

  def new
    @search_term = SearchTerm.new
    @locations = current_user.locations
  end

  def create
    search_term = params[:search_term]
    address = search_term.delete(:location)
    radius = search_term.delete(:radius)

    if address && search_term[:location_id].blank?
      searcher = GeoSearcher.new(address, Geocoder)
      begin
        result = searcher.search!
        location = Location.create(
          latitude: result.latitude,
          longitude: result.longitude,
          name: address,
          radius: radius,
          user: current_user)
        search_term[:location_id] = location.id
      rescue GeoSearchNoResultsException => e
      end
    end

    @locations = current_user.locations
    @search_term = SearchTerm.create(keywords: search_term[:keywords],
      location_id: search_term[:location_id],
      user: current_user)

    if @search_term.errors.any?
      render :new
    else
      flash[:notice] = "Search term added."
      redirect_to search_terms_path
    end
  end

  def destroy

  end

end
