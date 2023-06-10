class LocationService
  def get_location(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  private
    def conn
      Faraday.new(url: 'https://www.mapquestapi.com') do |faraday|
        faraday.params['key'] = ENV['MAPQUEST_API_KEY']
      end
    end

    def get_url(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end