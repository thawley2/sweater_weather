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
  end
end