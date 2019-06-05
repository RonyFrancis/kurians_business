# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # EXCEPTIONS = [Users::InvalidLoginError, Users::UserNotFoundError]
  #
  # rescue_from APIException do |e|
  #   response = { code: e.code,
  #                message: e.message,
  #                version: 1 }
  #   render json: response
  # end
  #
end
