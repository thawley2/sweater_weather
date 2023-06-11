require 'rails_helper'

RSpec.describe 'Weather API' do
  describe 'Sends weather data for a city' do
    it 'can send weather data for a city', :vcr do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      denver_weather = JSON.parse(response.body, symbolize_names: true)
      
      expect(denver_weather).to be_a Hash
      expect(denver_weather).to have_key :data
      expect(denver_weather[:data]).to be_a Hash
      expect(denver_weather[:data]).to have_key :id
      expect(denver_weather[:data][:id]).to eq(nil)
      expect(denver_weather[:data]).to have_key :type
      expect(denver_weather[:data][:type]).to eq('forecast')
      expect(denver_weather[:data]).to have_key :attributes
      expect(denver_weather[:data][:attributes]).to be_a Hash
      expect(denver_weather[:data][:attributes]).to have_key :current_weather
      expect(denver_weather[:data][:attributes]).to have_key :daily_weather
      expect(denver_weather[:data][:attributes]).to have_key :hourly_weather

      expect(denver_weather[:data][:attributes]).to_not have_key :name
      expect(denver_weather[:data][:attributes]).to_not have_key :region
      expect(denver_weather[:data][:attributes]).to_not have_key :country
      expect(denver_weather[:data][:attributes]).to_not have_key :lat
      expect(denver_weather[:data][:attributes]).to_not have_key :lon
      expect(denver_weather[:data][:attributes]).to_not have_key :tz_id
      expect(denver_weather[:data][:attributes]).to_not have_key :localtime_epoch
      expect(denver_weather[:data][:attributes]).to_not have_key :localtime

      denver_current = denver_weather[:data][:attributes][:current_weather]
      expect(denver_current).to be_a Hash
      expect(denver_current).to have_key :last_updated
      expect(denver_current[:last_updated]).to be_a String
      expect(denver_current).to have_key :temperature
      expect(denver_current[:temperature]).to be_a Float
      expect(denver_current).to have_key :feels_like
      expect(denver_current[:feels_like]).to be_a Float
      expect(denver_current).to have_key :humidity
      expect(denver_current[:humidity]).to be_a Integer
      expect(denver_current).to have_key :uvi
      expect(denver_current[:uvi]).to be_a Float
      expect(denver_current).to have_key :visibility
      expect(denver_current[:visibility]).to be_a Float
      expect(denver_current).to have_key :conditions
      expect(denver_current[:conditions]).to be_a String
      expect(denver_current).to have_key :icon
      expect(denver_current[:icon]).to be_a String

      expect(denver_weather[:data][:attributes][:daily_weather]).to be_an Array
      expect(denver_weather[:data][:attributes][:daily_weather].count).to eq(5)
      
      denver_weather[:data][:attributes][:daily_weather].each do |day|
        expect(day).to be_a Hash
        expect(day).to have_key :date
        expect(day[:date]).to be_a String
        expect(day).to have_key :sunrise
        expect(day[:sunrise]).to be_a String
        expect(day).to have_key :sunset
        expect(day[:sunset]).to be_a String
        expect(day).to have_key :max_temp
        expect(day[:max_temp]).to be_a Float
        expect(day).to have_key :min_temp
        expect(day[:min_temp]).to be_a Float
        expect(day).to have_key :conditions
        expect(day[:conditions]).to be_a String
        expect(day).to have_key :icon
        expect(day[:icon]).to be_a String
      end

      expect(denver_weather[:data][:attributes][:hourly_weather]).to be_an Array
      expect(denver_weather[:data][:attributes][:hourly_weather].count).to eq(24)

      denver_weather[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to be_a Hash
        expect(hour).to have_key :time
        expect(hour[:time]).to be_a String
        expect(hour).to have_key :temperature
        expect(hour[:temperature]).to be_a Float
        expect(hour).to have_key :conditions
        expect(hour[:conditions]).to be_a String
        expect(hour).to have_key :icon
        expect(hour[:icon]).to be_a String
      end
    end
  end
  
end