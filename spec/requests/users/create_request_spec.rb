require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'POST /api/v1/users' do
    it 'can create a new user' do
      user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

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
      expect(user_data[:data][:attributes][:email]).to be_a String
      expect(user_data[:data][:attributes]).to have_key :api_key
      expect(user_data[:data][:attributes][:api_key]).to be_a String

      expect(user_data[:data][:attributes]).to_not have_key :password_digest
    end

    it 'returns an error if email is already taken status 409' do
      User.create!(email: "whatever@example.com", password: "password", api_key: "lfdkgj34t98sd34dfhj")
      user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Validation failed: Email has already been taken")
    end

    it 'returns an error if the password and confirmation_password do not match status 400' do
      user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "not_the_same"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Password and password confirmation do not match")
    end

    it 'returns an error if a field is missing, status 422' do
      user_params = {
        email: "",
        password: "password",
        password_confirmation: "password"
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Validation failed: Email can't be blank")
    end
  end
end