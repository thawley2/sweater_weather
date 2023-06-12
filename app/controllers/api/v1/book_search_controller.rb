class Api::V1::BookSearchController < ApplicationController
  def index
    render json: BooksSerializer.new(WeatherFacade.new(params[:location], params[:quantity]).books_by_location)
  end
end