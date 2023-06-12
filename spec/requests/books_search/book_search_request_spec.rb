require 'rails_helper'

RSpec.describe 'Book Search API' do
  describe 'Happy Path' do
    it 'returns a list of books based on the location and quantity of books requested', :vcr do
      headers = {"CONTENT_TYPE" => "application/json"}
      get "/api/v1/book-search?location=denver,co&quantity=5", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      book_forecast = JSON.parse(response.body, symbolize_names: true)

      expect(book_forecast).to be_a Hash
      expect(book_forecast).to have_key :data
      expect(book_forecast[:data]).to be_a Hash
      expect(book_forecast[:data]).to have_key :id
      expect(book_forecast[:data][:id]).to eq(nil)
      expect(book_forecast[:data]).to have_key :type
      expect(book_forecast[:data][:type]).to eq('books')
      expect(book_forecast[:data]).to have_key :attributes
      expect(book_forecast[:data][:attributes]).to be_a Hash
      expect(book_forecast[:data][:attributes]).to have_key :destination
      expect(book_forecast[:data][:attributes][:destination]).to be_a String
      expect(book_forecast[:data][:attributes]).to have_key :forecast
      expect(book_forecast[:data][:attributes][:forecast]).to be_a Hash
      expect(book_forecast[:data][:attributes][:forecast]).to have_key :summary
      expect(book_forecast[:data][:attributes][:forecast][:summary]).to be_a String
      expect(book_forecast[:data][:attributes][:forecast]).to have_key :temperature
      expect(book_forecast[:data][:attributes][:forecast][:temperature]).to be_a String
      expect(book_forecast[:data][:attributes]).to have_key :total_books_found
      expect(book_forecast[:data][:attributes][:total_books_found]).to be_a Integer
      expect(book_forecast[:data][:attributes]).to have_key :books
      expect(book_forecast[:data][:attributes][:books]).to be_an Array
      expect(book_forecast[:data][:attributes][:books].count).to eq(5)
      expect(book_forecast[:data][:attributes][:books].first).to be_a Hash
      expect(book_forecast[:data][:attributes][:books].first).to have_key :isbn
      expect(book_forecast[:data][:attributes][:books].first[:isbn]).to be_an Array
      expect(book_forecast[:data][:attributes][:books].first[:isbn].first).to be_a String
      expect(book_forecast[:data][:attributes][:books].first).to have_key :title
      expect(book_forecast[:data][:attributes][:books].first[:title]).to be_a String
      expect(book_forecast[:data][:attributes][:books].first).to have_key :publisher
      expect(book_forecast[:data][:attributes][:books].first[:publisher]).to be_an Array
      expect(book_forecast[:data][:attributes][:books].first[:publisher].first).to be_a String
    end
  end
end