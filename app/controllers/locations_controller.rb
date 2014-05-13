class LocationsController < ApplicationController

  def geocode
    address = params[:address]
    render status: 400, json: {} and return if address.length < 6

    searcher = GeoSearcher.new(params[:address], Geocoder)

    begin
      result = searcher.search!
      render status: 200, json: {latitude: result.latitude, longitude: result.longitude}
    rescue GeoSearchNoResultsException => e
      render status: 400, json: {}
    end

  end

end
