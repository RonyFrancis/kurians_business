module V1
  class UserProfileController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :fetch_params, only: [:create]
    def index
      current_user
      users = fetch_users(params[:page], params[:search_term])
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
      raise UnableToDeleteUser if current_user.id == user.id
      user.destroy
      render json: succes_response(
        "status": "user is deleted"
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def update
      current_user
      user = Users::FetchUserByIdQuery.new(id: params[:id]).call
      update_status = user.update_attributes(user_params)
      raise FailedToUpdateUser unless update_status == true
      render json: succes_response(
        "update_status": "user has been updated"
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def update_status
      users = Users::FetchUsersByIDS.new(ids: params[:ids]).call
      users.update(status: params[:status])
      render json: succes_response(
        "status": "users have been updated"
      )
    rescue APIException => e
      render json: error_response(e.code, e.message)
    end

    def create
      register_user(current_user, @params)
      send_registration_mail(@params[:user_params][:email])
      render json: succes_response(
        user_name: @params[:user_params][:email]
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

    def fetch_users(page, search_term)
      Users::FetchQuery.new(
        page: page, search_term: search_term
      ).call
    end

    def user_params
      params.require(:user).permit(
      :first_name, :last_name, :email, :forward_email, :mobile_number, :password,
       :status,:user_type, :address, :tfn, :dob,:client_type, :integration_type,
       :company_name, :trading_name,:abn_can,:company_tfn, :business_address,
       :business_phone_no, :business_email, :website, :industry,:nominated_contact_person,
       :nominated_contact_position, :account_management_email
       )
    end

    def register_user(current_user, params)
      Company::RegistrationQuery.new(
        current_user: current_user,
        user_params: params[:user_params]
      ).call
    end

    def send_registration_mail(email)
      UserMailer.with(
        email: email
      ).send_registration.deliver_later
    end
  end
end
