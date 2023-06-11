class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordInvalid, with: :error_message

  def error_message(error)
    if error.message.include?("Email can't be blank")
      render json: ErrorSerializer.serialize(error.message), status: 422
    else
      render json: ErrorSerializer.serialize(error.message), status: 409
    end
  end
end
