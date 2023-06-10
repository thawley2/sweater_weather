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
        expect(denver_weather_object.current_weather).to have_key :conditions
        expect(denver_weather_object.current_weather).to have_key :icon

        expect(denver_weather_object.daily_weather).to be_an Array
        expect(denver_weather_object.daily_weather.count).to eq(4)
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
  end
end