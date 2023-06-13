class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
    render json: RoadTripSerializer.new(RoadTripFacade.new(road_trip_params).road_trip)
    else
    render json: ErrorSerializer.serialize("API key is invalid"), status: 401
    end
  end

  private
    def road_trip_params
      params.permit(:origin, :destination)
    end
end