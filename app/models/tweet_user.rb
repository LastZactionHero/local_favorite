class TweetUser

  def initialize(data)
    @data = data
  end

  def data
    @data
  end
  
  def name
    @data[:name]
  end

  def screen_name
    @data[:screen_name]
  end

  def location
    @data[:location]
  end

  def profile_image_url
    @data[:profile_image_url]
  end

end
