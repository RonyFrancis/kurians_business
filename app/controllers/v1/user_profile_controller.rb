module V1
  class UserProfileController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
      current_user
      users = fetch_users(params[:page])
      render json: succes_response(
        users: users[0],
        pagination_details: users[1]
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def show
      current_user
      user = Users::FetchUserByIdQuery.new(id: params[:id]).call
      render json: succes_response(
        user: user
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def destroy
      current_user
      user = Users::FetchUserByIdQuery.new(id: params[:id]).call
      render json: succes_response(
        "status": "user is deleted" 
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    private

    def current_user
      @current_user ||= Users::AuthenticationQuery.new(
        email: params[:user_name], auth_token: params[:auth_token]
      ).call
    end

    def fetch_users(page)
      Users::FetchQuery.new(
        page: page
      ).call
    end
  end
end
