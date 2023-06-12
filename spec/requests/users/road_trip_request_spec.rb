require 'rails_helper'

RSpec.describe 'Road Trip API' do
  describe 'Happy Path' do
    xit 'can return the travel time and forecast for a road trip' do
      VCR.use_cassette('road_trip_request') do
        user = create(:user)

        trip_params = {
          origin: 'Denver,CO',
          destination: 'Chicago,IL',
          api_key: user.api_key
        }

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(trip_params)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        trip = JSON.parse(response.body, symbolize_names: true)

        expect(trip).to be_a Hash
        expect(trip).to have_key :data
        expect(trip[:data]).to be_a Hash
        expect(trip[:data]).to have_key :id
        expect(trip[:data][:id]).to eq(nil)
        expect(trip[:data]).to have_key :type
        expect(trip[:data][:type]).to eq('roadtrip')
        expect(trip[:data]).to have_key :attributes
        expect(trip[:data][:attributes]).to be_a Hash
        expect(trip[:data][:attributes]).to have_key :start_city
        expect(trip[:data][:attributes][:start_city]).to eq(trip_params[:origin])
        expect(trip[:data][:attributes]).to have_key :end_city
        expect(trip[:data][:attributes][:end_city]).to eq(trip_params[:destination])
        expect(trip[:data][:attributes]).to have_key :travel_time
        expect(trip[:data][:attributes][:travel_time]).to be_a String
        expect(trip[:data][:attributes]).to have_key :weather_at_eta
        expect(trip[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(trip[:data][:attributes][:weather_at_eta]).to have_key :datetime
        expect(trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a String
        expect(trip[:data][:attributes][:weather_at_eta]).to have_key :temperature
        expect(trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
        expect(trip[:data][:attributes][:weather_at_eta]).to have_key :conditions
        expect(trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
      end
    end
  end
end