class TwitterRestClient

  def self.construct(user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = APP_SETTINGS['twitter']['api_key']
      config.consumer_secret     = APP_SETTINGS['twitter']['api_secret']
      config.access_token        = user.twitter_access_token
      config.access_token_secret = user.twitter_access_token_secret
    end
  end

end
