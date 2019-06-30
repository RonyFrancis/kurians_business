# frozen_string_literal: true

module V1
  # BillsController
  class BillsController < ApplicationController
    skip_before_action :verify_authenticity_token
    # before_action :fetch_params, only: [:index]
    URL = "https://bbclients.com.au"

    def welcome
      render json: { a: 'msg' }
    end

    def index
      bills_details = fetch_bills(
        current_user, params[:page], URL
      )
      render json: succes_response(
        bills: bills_details[0],
        pagination_details: bills_details[1]
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def create
      add_bill(current_user, params)
      send_mails(current_user)
      # send_mail_to_admin(current_user)
      render json: succes_response(
        status: 'success'
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

    def fetch_bills(user, page, url)
      Bills::FetchQuery.new(
        user: user, page: page,
        url: url
      ).call
    end

    def current_user
      puts @params.inspect
      @current_user ||= Users::AuthenticationQuery.new(
        email: params[:user_name], auth_token: params[:auth_token]
      ).call
    end

    def send_mails(user)
      BillMailer.with(
        email: user.email
      ).send_bill_mail.deliver_later
    end

    def send_mail_to_admin(user)
      BillMailer.with(
        email: user.email
      ).send_bill_to_admin_mail.deliver_later
    end
  end
end
