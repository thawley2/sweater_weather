require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists and has attributes' do
    trip_data = {
      start_city: 'ponca city, ok',
      end_city: 'denver, co',
      travel_time: '12:00:00',
      weather_at_eta: {
        datetime: '2021-06-12 12:00:00',
        temperature: 50.0,
        conditions: 'cloudy'
      }
    }
    trip = RoadTrip.new(trip_data)

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq('ponca city, ok')
    expect(trip.end_city).to eq('denver, co')
    expect(trip.travel_time).to eq('12:00:00')
    expect(trip.weather_at_eta).to be_a Hash
    expect(trip.weather_at_eta).to have_key :datetime
    expect(trip.weather_at_eta[:datetime]).to eq('2021-06-12 12:00:00')
    expect(trip.weather_at_eta).to have_key :temperature
    expect(trip.weather_at_eta[:temperature]).to eq(50.0)
    expect(trip.weather_at_eta).to have_key :conditions
    expect(trip.weather_at_eta[:conditions]).to eq('cloudy')
  end
end