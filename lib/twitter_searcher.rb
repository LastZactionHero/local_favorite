class TwitterSearcher
  attr_reader :results

  def initialize(keywords, twitter_client, options = {})
    @keywords = keywords
    @client = twitter_client

    @latitude = options[:latitude]
    @longitude = options[:longitude]
    @radius = options[:radius]
    @radius_unit = options[:radius_unit]
  end

  def search!
    Rails.logger.warn "Searching with geo string: #{geo_string}"

    results = @client.search(@keywords,
      geocode: geo_string,
      count: search_count,
      result_type: 'recent',
      lang: 'en'
      ).take(search_count)
    @results = results.map{|r| r.to_h}
  end

  private

  def search_count
    10
  end

  def geo_string
    Rails.logger.warn "#{@latitude} #{@longitude} #{@radius} #{@radius_unit}"

    
    if @latitude && @longitude && @radius && @radius_unit
      "#{@latitude},#{@longitude},#{@radius}#{@radius_unit}"
    else
      nil
    end
  end


end
