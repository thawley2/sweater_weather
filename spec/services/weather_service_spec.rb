require 'rails_helper'

RSpec.describe WeatherService do
  describe 'Establish connection' do
    it 'can connect to the OpenWeather API' do
      VCR.use_cassette('denver_weather_service') do
        denver_weather = WeatherService.new.get_weather('39.738453', '-104.984853')

        expect(denver_weather).to be_a Hash
      end
    end

    it 'can return the current weather and forecast for a location' do
      VCR.use_cassette('denver_weather_service') do
        denver_weather = WeatherService.new.get_weather('39.738453', '-104.984853')

        expect(denver_weather).to have_key :current
        expect(denver_weather[:current]).to have_key :last_updated
        expect(denver_weather[:current][:last_updated]).to be_a String
        expect(denver_weather[:current]).to have_key :temp_f
        expect(denver_weather[:current][:temp_f]).to be_a Float
        expect(denver_weather[:current]).to have_key :feelslike_f
        expect(denver_weather[:current][:feelslike_f]).to be_a Float
        expect(denver_weather[:current]).to have_key :humidity
        expect(denver_weather[:current][:humidity]).to be_a Integer
        expect(denver_weather[:current]).to have_key :uv 
        expect(denver_weather[:current][:uv]).to be_a Float
        expect(denver_weather[:current]).to have_key :vis_miles
        expect(denver_weather[:current][:vis_miles]).to be_a Float
        
        expect(denver_weather).to have_key :forecast
        expect(denver_weather[:forecast][:forecastday]).to be_an Array
        expect(denver_weather[:forecast][:forecastday][0][:day]).to have_key :condition
        expect(denver_weather[:forecast][:forecastday][0][:day][:condition]).to have_key :text
        expect(denver_weather[:forecast][:forecastday][0][:day][:condition][:text]).to be_a String
        expect(denver_weather[:forecast][:forecastday][0][:day][:condition]).to have_key :icon
        expect(denver_weather[:forecast][:forecastday][0][:day][:condition][:icon]).to be_a String
      end
    end

    it 'can return the daily weather of the next 5 days' do
      VCR.use_cassette('denver_weather_service') do
        denver_weather = WeatherService.new.get_weather('39.738453', '-104.984853')
    
        expect(denver_weather).to have_key :forecast
        expect(denver_weather[:forecast][:forecastday]).to be_an Array

        denver_weather[:forecast][:forecastday].each do |day|
          expect(day).to have_key :date
          expect(day[:date]).to be_a String
          expect(day).to have_key :day
          expect(day[:day]).to be_a Hash
          expect(day[:day]).to have_key :maxtemp_f
          expect(day[:day][:maxtemp_f]).to be_a Float
          expect(day[:day]).to have_key :mintemp_f
          expect(day[:day][:mintemp_f]).to be_a Float
          expect(day[:day]).to have_key :condition
          expect(day[:day][:condition]).to have_key :text
          expect(day[:day][:condition][:text]).to be_a String
          expect(day[:day][:condition]).to have_key :icon
          expect(day[:day][:condition][:icon]).to be_a String
          expect(day[:astro]).to have_key :sunrise
          expect(day[:astro][:sunrise]).to be_a String
          expect(day[:astro]).to have_key :sunset
          expect(day[:astro][:sunset]).to be_a String
        end
      end
    end

    it 'can return the hourly weather of the current day' do
      VCR.use_cassette('denver_weather_service') do
        denver_weather = WeatherService.new.get_weather('39.738453', '-104.984853')

        expect(denver_weather[:forecast][:forecastday][0]).to have_key :hour
        expect(denver_weather[:forecast][:forecastday][0][:hour]).to be_an Array

        denver_weather[:forecast][:forecastday][0][:hour].each do |hour|
          expect(hour).to have_key :time
          expect(hour[:time]).to be_a String
          expect(hour).to have_key :temp_f
          expect(hour[:temp_f]).to be_a Float
          expect(hour).to have_key :condition
          expect(hour[:condition]).to have_key :text
          expect(hour[:condition][:text]).to be_a String
          expect(hour[:condition]).to have_key :icon
          expect(hour[:condition][:icon]).to be_a String
        end
      end
    end
  end
end

