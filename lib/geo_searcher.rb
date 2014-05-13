class GeoSearchResult
  attr_reader :latitude, :longitude, :city, :region

  def initialize(latitude, longitude, city, region)
    @latitude = latitude
    @longitude = longitude
    @city = city
    @region = region
  end
end

class GeoSearchNoResultsException < StandardError
end

class GeoSearcher
  attr_reader :result

  def initialize(search, geocoder_type)
    @search = search
    @geocoder_type = geocoder_type

    @result = nil
  end

  def search!
    results = geo_search!(@search)
    parse_results(results)
  end

  private

  def geo_search!(search_term)
    @geocoder_type.search(search_term)
  end

  def parse_results(results)
    result = results[0]
    raise GeoSearchNoResultsException unless result

    @result = GeoSearchResult.new(
      result.latitude,
      result.longitude,
      result.city,
      result.state_code)
  end

end
