require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    it 'returns an object with road trip and weather data', :vcr do
      VCR.use_cassette('denver_roadtrip_weather', allow_playback_repeats: true) do
        frozen_time = Time.new(2023, 6, 12, 12, 0, 0, '+00:00')
        Timecop.freeze(frozen_time) do
          trip_data = {
            origin: 'ponca city, ok',
            destination: 'denver, co'
          }
          trip = RoadTripFacade.new(trip_data).road_trip
          
          expect(trip).to be_a RoadTrip
          expect(trip.start_city).to eq('ponca city, ok')
          expect(trip.end_city).to eq('denver, co')
          expect(trip.travel_time).to be_a String
          expect(trip.weather_at_eta).to be_a Hash
          expect(trip.weather_at_eta).to have_key :datetime
          expect(trip.weather_at_eta[:datetime]).to be_a String
          expect(trip.weather_at_eta).to have_key :temperature
          expect(trip.weather_at_eta[:temperature]).to be_a Float
          expect(trip.weather_at_eta).to have_key :conditions
          expect(trip.weather_at_eta[:conditions]).to be_a String
        end
      end
    end
  end
end