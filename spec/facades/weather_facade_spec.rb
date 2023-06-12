require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods' do
    
    it 'returns a weather object for a given location' do
      VCR.use_cassette('denver_weather_facade', allow_playback_repeats: true) do
        denver_facade = WeatherFacade.new('denver,co')
        denver_weather_object = denver_facade.weather
        
        expect(denver_weather_object).to be_a Weather
        expect(denver_weather_object.current_weather).to be_a Hash
        expect(denver_weather_object.current_weather).to have_key :last_updated
        expect(denver_weather_object.current_weather).to have_key :temperature
        expect(denver_weather_object.current_weather).to have_key :feels_like
        expect(denver_weather_object.current_weather).to have_key :humidity
        expect(denver_weather_object.current_weather).to have_key :uvi
        expect(denver_weather_object.current_weather).to have_key :visibility
        expect(denver_weather_object.current_weather).to have_key :conditions
        expect(denver_weather_object.current_weather).to have_key :icon

        expect(denver_weather_object.daily_weather).to be_an Array
        expect(denver_weather_object.daily_weather.count).to eq(5)
        expect(denver_weather_object.daily_weather.first).to be_a Hash
        expect(denver_weather_object.daily_weather.first).to have_key :date
        expect(denver_weather_object.daily_weather.first).to have_key :sunrise
        expect(denver_weather_object.daily_weather.first).to have_key :sunset
        expect(denver_weather_object.daily_weather.first).to have_key :max_temp
        expect(denver_weather_object.daily_weather.first).to have_key :min_temp
        expect(denver_weather_object.daily_weather.first).to have_key :conditions
        expect(denver_weather_object.daily_weather.first).to have_key :icon

        expect(denver_weather_object.hourly_weather).to be_an Array
        expect(denver_weather_object.hourly_weather.count).to eq(24)
        expect(denver_weather_object.hourly_weather.first).to be_a Hash
        expect(denver_weather_object.hourly_weather.first).to have_key :time
        expect(denver_weather_object.hourly_weather.first).to have_key :temperature
        expect(denver_weather_object.hourly_weather.first).to have_key :conditions
        expect(denver_weather_object.hourly_weather.first).to have_key :icon
      end
    end

    it 'returns a book-search object for a given location, with some weather', :vcr do
      books_by_location = WeatherFacade.new('denver,co', 5).books_by_location

      expect(books_by_location).to be_a BooksByLocation
      expect(books_by_location.destination).to eq('denver,co')
      expect(books_by_location.forecast).to be_a Hash
      expect(books_by_location.forecast).to have_key :summary
      expect(books_by_location.forecast).to have_key :temperature
      expect(books_by_location.total_books_found).to be_an Integer
      expect(books_by_location.books).to be_an Array
      expect(books_by_location.books.count).to eq(5)
      expect(books_by_location.books.first).to be_a Hash
      expect(books_by_location.books.first).to have_key :isbn
      expect(books_by_location.books.first[:isbn]).to be_an Array
      expect(books_by_location.books.first[:isbn].first).to be_a String
      expect(books_by_location.books.first).to have_key :title
      expect(books_by_location.books.first[:title]).to be_a String
      expect(books_by_location.books.first).to have_key :publisher
      expect(books_by_location.books.first[:publisher]).to be_an Array
      expect(books_by_location.books.first[:publisher].first).to be_a String
    end
  end
end