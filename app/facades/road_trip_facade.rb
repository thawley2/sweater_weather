class RoadTripFacade
  def initialize(locations)
    @origin = locations[:origin]
    @destination = locations[:destination]
    @origin_lat = directions_data[:locations][0][:latLng][:lat]
    @origin_lon = directions_data[:locations][0][:latLng][:lng]
    @dest_lat = directions_data[:locations][1][:latLng][:lat]
    @dest_lon = directions_data[:locations][1][:latLng][:lng]
  end

  def road_trip
    RoadTrip.new(road_trip_data)
  end

  private
    def location_service
      @_location_service ||= LocationService.new
    end

    def weather_service
      @_weather_service ||= WeatherService.new
    end

    def directions_data
      @_directions_data ||= location_service.get_directions(@origin, @destination)[:route]
    end

    def destination_weather_data
      @_destination_weather_data ||= weather_service.get_weather(@dest_lat, @dest_lon)[:forecast][:forecastday]
    end

    def time_at_destination
      @_start_time ||= Time.now.in_time_zone(Timezone.lookup(@origin_lat, @origin_lon).name)
      @_end_time_origin ||= @_start_time + directions_data[:time]
      @_arrival_time ||= @_end_time_origin.in_time_zone(Timezone.lookup(@dest_lat, @dest_lon).name)
    end

    def weather_at_destination_day
      @_day ||= destination_weather_data.find do |day|
        day[:date] == time_at_destination.strftime('%Y-%m-%d')
      end
    end

    def weather_at_destination_hour
      @_hour ||= weather_at_destination_day[:hour].find do |hour|
        hour[:time] == time_at_destination.strftime("%Y-%m-%d %H:00")  
      end  
    end

    def road_trip_data
      {
        start_city: @origin,
        end_city: @destination,
        travel_time: directions_data[:formattedTime],
        weather_at_eta: {
          datetime: weather_at_destination_hour[:time],
          temperature: weather_at_destination_hour[:temp_f],
          conditions: weather_at_destination_hour[:condition][:text]
        }
      }
    end
end