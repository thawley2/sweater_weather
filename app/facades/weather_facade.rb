class WeatherFacade
  def initialize(location, book_quantity = nil)
    @location = location
    @book_quantity = book_quantity
    @lat = get_location[:lat]
    @lon = get_location[:lng]
  end

  def weather
    @_weather ||= Weather.new(format_weather_data)
  end

  def books_by_location
    @_books_by_location ||= BooksByLocation.new(format_forecast, format_books_data)
  end

  private
    def books_service
      @_books_service ||= BooksService.new
    end

    def location_service
      @_location_service ||= LocationService.new
    end

    def weather_service
      @_weather_service ||= WeatherService.new
    end

    def get_location
      @_get_location ||= location_service.get_location(@location)[:results][0][:locations][0][:latLng]
    end

    def weather_data
      @_weather_data ||= weather_service.get_weather(@lat, @lon)
    end

    def books_data
      @_books_data ||= books_service.get_books(@location)
    end

    def format_weather_data
        {
          current_weather: current_weather,
          daily_weather: daily_weather,
          hourly_weather: hourly_weather
        }
    end

    def current_weather
      weather ||= weather_data[:current]
      {
        last_updated: weather[:last_updated],
        temperature: weather[:temp_f],
        feels_like: weather[:feelslike_f],
        humidity: weather[:humidity],
        uvi: weather[:uv],
        visibility: weather[:vis_miles],
        conditions: weather[:condition][:text],
        icon: weather[:condition][:icon]
      }
    end

    def daily_weather
      weather_data[:forecast][:forecastday][1..5].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        conditions: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
      end
    end

    def hourly_weather
      weather_data[:forecast][:forecastday][0][:hour].map do |hour|
      {
        time: DateTime.parse(hour[:time]).strftime("%H:%M"),
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
      end
    end

    def format_books_data
      books = {
        total_books: books_data[:numFound],
        books: books_data[:docs][0..@book_quantity].map do |book|
          {
            isbn: book[:isbn],
            title: book[:title],
            publisher: book[:publisher]
          }
        end
      }
    end

    def format_forecast 
      {
        destination: @location,
        forecast: {
          summary: weather_data[:current][:weather][0][:description],
          temperature: weather_data[:current][:temp]
        }
      }
    end
end