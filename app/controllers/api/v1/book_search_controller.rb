class Api::V1::BookSearchController < ApplicationController
  def index
    if params[:location].present? && params[:quantity].to_i > 1
      render json: BooksSerializer.new(WeatherFacade.new(params[:location], params[:quantity]).books_by_location)
    else
      render json: ErrorSerializer.serialize("Invalid location or quantity"), status: 400
    end
  end
end