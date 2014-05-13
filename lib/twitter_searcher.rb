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
    results = @client.search(@keywords,
      geocode: geo_string,
      count: search_count,
      result_type: 'recent',
      lang: 'en'
      ).take(search_count)
    results.delete_if{|r| r.reply?}
    @results = results.map{|r| r.to_h}
  end

  private

  def search_count
    10
  end

  def geo_string
    if @latitude && @longitude && @radius && @radius_unit
      "#{@latitude},#{@longitude},#{@radius}#{@radius_unit}"
    else
      nil
    end
  end


end
