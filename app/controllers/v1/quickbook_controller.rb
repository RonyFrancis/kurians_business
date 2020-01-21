module V1
  class QuickbookController < ApplicationController
    require 'rest-client'
    require "uri"
    require "net/http"
    skip_before_action :verify_authenticity_token

    def prepare_auth_code_url
      url = QuickBook::AuthUrl.new().call
      redirect_to(url)
    end

    def redirect_url
      tokens = QuickBook::AuthToken.new(code: params[:code]).call
      newToken = QuickBook::RefreshToken.new(refresh_tokens: tokens.refresh_token).call
      url = URI("https://quickbooks.api.intuit.com/v3/company/" + params[:realmId] + "/companyinfo/" + params[:realmId] + "?minorversion=42")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json"
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{newToken.access_token}"
      response = https.request(request)
    end

    def get_auth_token
      tokens = QuickBook::AuthToken.new().call
      render json: {"token": tokens}
    end
  end
end
