require 'rails_helper'

RSpec.describe LocationService do
  describe 'Establish connection' do
    it 'can connect to the MapQuest API' do
      VCR.use_cassette('denver_location_service') do
        denver = LocationService.new.get_location('denver,co')
        
        expect(denver).to be_a Hash
        expect(denver).to have_key :results
        expect(denver[:results][0][:locations][0][:latLng]).to have_key :lat
        expect(denver[:results][0][:locations][0][:latLng]).to have_key :lng
        expect(denver[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(denver[:results][0][:locations][0][:latLng][:lng]).to be_a Float
      end
    end

    it 'can return the directions between two locations' do
      VCR.use_cassette('ponca_city_to_denver_location_service') do
        pc_to_dv = LocationService.new.get_directions('ponca city, ok', 'denver, co')

        expect(pc_to_dv).to be_a Hash
        expect(pc_to_dv).to have_key :route
        expect(pc_to_dv[:route]).to have_key :formattedTime
        expect(pc_to_dv[:route][:formattedTime]).to be_a String
        expect(pc_to_dv[:route][:locations][0][:latLng]).to have_key :lat
        expect(pc_to_dv[:route][:locations][0][:latLng][:lat]).to be_a Float
        expect(pc_to_dv[:route][:locations][0][:latLng]).to have_key :lng
        expect(pc_to_dv[:route][:locations][0][:latLng][:lng]).to be_a Float
        expect(pc_to_dv[:route][:locations][1][:latLng]).to have_key :lat
        expect(pc_to_dv[:route][:locations][1][:latLng][:lat]).to be_a Float
        expect(pc_to_dv[:route][:locations][1][:latLng]).to have_key :lng
        expect(pc_to_dv[:route][:locations][1][:latLng][:lng]).to be_a Float

        
      end
    end
  end
end