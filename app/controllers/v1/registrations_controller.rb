# frozen_string_literal: true

module V1
  # RegistrationsController
  class RegistrationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :fetch_params

    def create
      register_user(current_user, @params)
      send_registration_mail(@params[:email])
      render json: succes_response(
        user_name: @params[:email]
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    private

    def register_user(current_user, params)
      Users::RegistrationQuery.new(
        current_user: current_user,
        user_params: params
      ).call
    end

    def send_registration_mail(email)
      UserMailer.with(
        email: email
      ).send_registration.deliver_later
    end
  end
end
