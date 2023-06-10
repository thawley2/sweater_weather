class Api::V1::WeathersController < ApplicationController
  def index
    render json: ForecastSerializer.new(WeatherFacade.new(params[:location]).weather)
  end
end