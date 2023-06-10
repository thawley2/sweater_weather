class WeatherService
  def get_weather(lat, lon)
    get_url("/v1/forecast.json?q=#{lat},#{lon}&days=6")
  end

  private
    def conn 
      Faraday.new(url: 'http://api.weatherapi.com') do |faraday|
        faraday.params['key'] = ENV['WEATHER_API_KEY']
      end
    end

    def get_url(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end