class Api::V1::UsersController < ApplicationController

  def create
    begin
      if params[:password] == params[:password_confirmation]
        user = User.create!(user_params)
        user.update(api_key: SecureRandom.hex(13))
        render json: UsersSerializer.new(user), status: 201
      else
        render json: ErrorSerializer.serialize("Password and password confirmation do not match"), status: 400
      end
      rescue ActiveRecord::RecordInvalid => error
        render json: ErrorSerializer.serialize(error), status: 422
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end