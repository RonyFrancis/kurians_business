# frozen_string_literal: true

module V1
  # UsersController
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :fetch_params,  only: [:sign_in, :sign_out]

    def sign_in
      user = valid_user(@params[:email], @params[:password], @params[:platform])
      user.update(auth_token: SecureRandom.uuid)
      render json: succes_response(
        auth_token: user.auth_token,
        user_type: user_type(user),
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        forward_email: user.forward_email,
        mobile_number: user.mobile_number
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def sign_out
      current_user.update(auth_token: '')
      render json: succes_response(
        { status_message: 'user signed out' }
      )
      rescue APIException => e
        render json: error_response(e.code, e.message)
    end

    private

    def valid_user(email, password, platform)
      Users::LoginQueries.new(
        email: email, password: password, platform: platform
      ).call
    end

    def user_type(user)
      user.is_admin? ? 'admin' : 'user'
    end
  end
end
