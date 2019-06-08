module V1
  class PasswordController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :fetch_params
    def recover_password
      create_temp_password(@params[:email])
      render json: succes_response(
        status_message: 'temp password created'
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def change_password
      update_password(
        @params[:old_password], @params[:user_name],
        @params[:new_password]
      )
      render json: succes_response(
        status_message: 'password changed'
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    private

    def create_temp_password(email)
      Passwords::TempPasswordQuery.new(
        email: email
      ).call
    end

    def update_password(password, user_name, new_password)
      Passwords::UpdateQuery.new(
        old_password: password, user_name: user_name,
        new_password: new_password
      ).call
    end
  end
end
