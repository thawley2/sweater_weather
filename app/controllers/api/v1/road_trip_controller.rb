class Api::V1::RoadTripController < ApplicationController
  def create
    #come back to this
    render json: RoadTripSerializer.new(RoadTripFacade.new(road_trip_params).road_trip)
  end

  private
    def road_trip_params
      params.permit(:origin, :destination)
    end
end