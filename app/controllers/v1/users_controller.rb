# frozen_string_literal: true

module V1
  # UsersController
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :fetch_params

    def sign_in
      user = valid_user(@params['email'], @params['password'])
      user.update(auth_token: SecureRandom.uuid)
      render json: succes_response(
        auth_token: user.auth_token,
        user_type: user_type(user)
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def sign_out; end

    private

    def fetch_params
      @params = JSON.parse(request.raw_post)
    end

    def valid_user(email, password)
      Users::LoginQueries.new(
        email: email, password: password
      ).call
    end

    def error_response(code, message)
      ResponseFormatter.new(
        code: code, message: message
      ).call
    end

    def succes_response(data)
      ResponseFormatter.new(
        data: data
      ).call
    end

    def user_type(user)
      user.is_admin? ? 'admin' : 'user'
    end
  end
end
