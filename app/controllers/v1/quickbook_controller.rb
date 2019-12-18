module V1
  class QuickbookController < ApplicationController
    require 'rest-client'
    skip_before_action :verify_authenticity_token

    def prepare_auth_code_url
      url = QuickBook::AuthUrl.new().call
      redirect_to(url)
    end

    def redirect_url
      tokens = QuickBook::AuthToken.new(code: params[:code]).call
      newToken = QuickBook::RefreshToken.new(refresh_tokens: tokens.refresh_token).call
      url = "https://quickbooks.api.intuit.com/v3/company/123146329989269/companyinfo/" + params[:realmId] + "?minorversion=42"
      resp = RestClient::Request.execute(method: :get, url: url,
                            headers: {
                              :Authorization =>  newToken.access_token,
                              :ContentType => 'application/json'
                            })
      render json: {"resp": resp}
    end

    def get_auth_token
      tokens = QuickBook::AuthToken.new().call
      render json: {"token": tokens}
    end
  end
end
