class Api::V1::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(WeatherFacade.new(params[:location]).weather)
  end
end