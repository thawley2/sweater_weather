class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: ErrorSerializer.serialize("Email or Password are incorrect"), status: 401
    end
  end
end