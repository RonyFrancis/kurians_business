# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= Users::AuthenticationQuery.new(
      email: @params['email'], auth_token: @params['auth_token']
    ).call
  end

  private
  
  def fetch_params
    @params = JSON.parse(request.raw_post)
  end
end
