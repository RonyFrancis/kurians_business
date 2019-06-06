# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= Users::AuthenticationQuery.new(
      email: @params['email'], auth_token: @params['auth_token']
    ).call
  end

  private

  def fetch_params
    @params = JSON.parse(request.raw_post, symbolize_names: true)
  end

  def error_response(code, message)
    ResponseFormatter.new(
      code: code, message: message
    ).call
  end

  def succes_response(data)
    ResponseFormatter.new(data: data).call
  end
end
