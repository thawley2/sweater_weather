class BooksByLocation
  attr_reader :destination, :forecast, :total_books_found, :books, :id

  def initialize(forecast_data, books_data)
    @id = nil
    @destination = forecast_data[:destination]
    @forecast = forecast_data[:forecast]
    @total_books_found = books_data[:total_books]
    @books = books_data[:books]
  end
end