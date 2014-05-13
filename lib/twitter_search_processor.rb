class TwitterSearchProcessor
  attr_reader :stored

  def initialize(search_term, user, searcher_type, client_type, store_type)
    @search_term  = search_term
    @user = user
    @client = client_type.construct(@user)
    @store_type = store_type

    @location = @search_term.location
    if @location
      @searcher = searcher_type.new(@search_term.keywords, @client,
        {latitude: @location.latitude,
         longitude: @location.longitude,
         radius: @location.radius,
         radius_unit: @location.radius_unit,
         since: 3.hours.ago
         })
    else
      @searcher = searcher_type.new(@search_term.keywords, @client)
    end
  end

  def process!
    results = @searcher.search!
    store_results!(results)
  end

  def store_results!(results)
    @stored = []

    begin
      results.each do |result|
        @stored << @store_type.create(
          tweet_id: result[:id],
          data: result.to_s,
          user: @user,
          search_term: @search_term)
      end
    rescue ActiveRecord::StatementInvalid => e
    end

    @stored
  end
end
