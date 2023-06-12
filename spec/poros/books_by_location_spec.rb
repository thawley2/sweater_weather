require 'rails_helper'

RSpec.describe BooksByLocation do
  it 'exists and has attributes' do
    forecast_data = {
      destination: 'denver, co',
      forecast: {
        summary: 'cloudy',
        temperature: "50.0 F"
      }
    }

    books_data = {
      total_books: 700,
      books: [
        {
          isbn: ['123456', '465789'],
          title: 'Denver, the best city ever',
          publisher: ['Denver Publishing'],
        },
        {
          isbn: ['468765', '897325135'],
          title: 'Denver Electrical Grids',
          publisher: ['Electricity Publishing'],
        }
      ]
    }

    books_with_weather = BooksByLocation.new(forecast_data, books_data)

    expect(books_with_weather).to be_a BooksByLocation
    expect(books_with_weather.destination).to eq('denver, co')
    expect(books_with_weather.forecast).to be_a Hash
    expect(books_with_weather.forecast).to have_key :summary
    expect(books_with_weather.forecast[:summary]).to eq('cloudy')
    expect(books_with_weather.forecast).to have_key :temperature
    expect(books_with_weather.forecast[:temperature]).to eq('50.0 F')
    expect(books_with_weather.total_books_found).to eq(700)
    expect(books_with_weather.books).to be_an Array
    expect(books_with_weather.books.count).to eq(2)
    expect(books_with_weather.books.first).to be_a Hash
    expect(books_with_weather.books.first).to have_key :isbn
    expect(books_with_weather.books.first[:isbn]).to be_an Array
    expect(books_with_weather.books.first[:isbn].count).to eq(2)
    expect(books_with_weather.books.first[:isbn].first).to eq('123456')
    expect(books_with_weather.books.first[:isbn].last).to eq('465789')
    expect(books_with_weather.books.first).to have_key :title
    expect(books_with_weather.books.first[:title]).to eq('Denver, the best city ever')
    expect(books_with_weather.books.first).to have_key :publisher
    expect(books_with_weather.books.first[:publisher]).to be_an Array
    expect(books_with_weather.books.first[:publisher].count).to eq(1)
    expect(books_with_weather.books.first[:publisher].first).to eq('Denver Publishing')
  end
end