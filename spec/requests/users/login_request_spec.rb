require 'rails_helper'

RSpec.describe 'User Login' do
  describe 'POST /api/v1/sessions' do
    it 'can login a user' do
      user = create(:user)

      user_params = {
        email: user.email,
        password: user.password
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user_data = JSON.parse(response.body, symbolize_names: true)

      expect(user_data).to be_a Hash
      expect(user_data).to have_key :data
      expect(user_data[:data]).to be_a Hash
      expect(user_data[:data]).to have_key :id
      expect(user_data[:data][:id]).to be_a String
      expect(user_data[:data]).to have_key :type
      expect(user_data[:data][:type]).to eq('users')
      expect(user_data[:data]).to have_key :attributes
      expect(user_data[:data][:attributes]).to be_a Hash
      expect(user_data[:data][:attributes]).to have_key :email
      expect(user_data[:data][:attributes][:email]).to eq(user.email)
      expect(user_data[:data][:attributes][:email]).to be_a String
      expect(user_data[:data][:attributes]).to have_key :api_key
      expect(user_data[:data][:attributes][:api_key]).to eq(user.api_key)
      expect(user_data[:data][:attributes][:api_key]).to be_a String

      expect(user_data[:data][:attributes]).to_not have_key :password_digest
    end

    it 'returns an error if the password does not match the record' do
      user = create(:user)
      user_params = {
        email: user.email,
        password: 'wrong_password'
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Email or Password are incorrect")
    end

    it 'returns an error if the email does not match the record' do
      user = create(:user)
      user_params = {
        email: "wrong@email.com",
        password: user.password
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Email or Password are incorrect")
    end

    it 'returns an error if the email field is left blank' do
      user = create(:user)

      user_params = {
        email: "",
        password: user.password
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Email or Password are incorrect")
    end

    it 'returns an error if the password field is left blank' do
      user = create(:user)
      user_params = {
        email: "wrong@email.com",
        password: ''
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Email or Password are incorrect")
    end
  end
end