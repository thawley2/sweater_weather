require 'rails_helper'

RSpec.describe 'Book Search API' do
  describe 'Happy Path' do
    it 'returns a list of books based on the location and quantity of books requested', :vcr do
      headers = {"CONTENT_TYPE" => "application/json"}
      get "/api/v1/book-search?location=denver,co&quantity=5", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      book_forecast = JSON.parse(response.body, symbolize_names: true)
    end
  end
end