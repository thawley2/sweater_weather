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

      
    end
  end
  
end