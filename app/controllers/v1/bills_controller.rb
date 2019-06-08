module V1
  # BillsController
  class BillsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :fetch_params

    def create
      add_bill(current_user, @params)
      render json: succes_response(
        user_name: @params[:user_name]
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    private

    def add_bill(current_user, params)
      Bills::CreateQuery.new(
        current_user: current_user,
        bill_params: params
      ).call
    end
  end
end
