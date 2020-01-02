# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= Users::AuthenticationQuery.new(
      email: @params[:user_name], auth_token: @params[:auth_token]
    ).call
  end

  def frontend_index_html
    render file: 'public/index.html', layout: false
  end

  private


  def fetch_params
	  Rails.logger.info request.raw_post.inspect
	  @params = JSON.parse(URI.unescape(request.raw_post), symbolize_names: true)
  end

  def error_response(code, message)
    ResponseFormatter.new(
	    code: code.to_i, message: message
    ).call
  end

  def succes_response(data)
    ResponseFormatter.new(data: data).call
  end
end
