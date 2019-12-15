# frozen_string_literal: true

module Company
  class RegistrationQuery
    attr_reader :current_user, :user_params
    def initialize(current_user:, user_params:)
      @current_user = current_user
      @user_params = user_params
    end

    def call
      raise InvalidParamsError unless valid_params?
      raise NotAdminUserError unless current_user.is_admin
      raise InvalidUserParamsError unless valid_users_params?
      raise DuplicateUserError unless register

      true
    end

    private

    def valid_params?
      (current_user && user_params).present?
    end

    def valid_users_params?
      (user_params[:email] && user_params[:forward_email]).present? && \
        (user_params[:first_name] && user_params[:last_name]).present? && \
        (user_params[:mobile_number] && user_params[:password]).present? && \
        (user_params[:status] && user_params[:user_type]).present? && \
        (user_params[:address] && user_params[:tfn]).present? && \
        (user_params[:dob] && user_params[:client_type]).present? && \
        (user_params[:company_name] && user_params[:trading_name]).present? && \
        (user_params[:abn_can] && user_params[:company_tfn]).present? && \
        (user_params[:business_address] && user_params[:business_phone_no]).present? && \
        (user_params[:business_email] && user_params[:website]).present? && \
        (user_params[:industry] && user_params[:nominated_contact_person]).present? && \
        (user_params[:nominated_contact_position] && user_params[:account_management_email]).present? && \
        (user_params[:integration_type]).present?
    end

    def register
      user = User.new(
               email: user_params[:email], forward_email: user_params[:forward_email],
               mobile_number: user_params[:mobile_number], first_name: user_params[:first_name],
               last_name: user_params[:last_name], password: Base64.encode64(user_params[:password]),
               status: user_params[:status], user_type: user_params[:user_type],
               address: user_params[:address], tfn: user_params[:tfn], dob: user_params[:dob],
               client_type: user_params[:client_type], company_name: user_params[:company_name],
               company_tfn: user_params[:company_tfn], trading_name: user_params[:trading_name],
               abn_can: user_params[:abn_can], business_address: user_params[:business_address],
               business_phone_no: user_params[:business_phone_no], business_email: user_params[:business_email],
               website: user_params[:website], industry: user_params[:industry],
               nominated_contact_person: user_params[:nominated_contact_person],
               nominated_contact_position: user_params[:nominated_contact_position],
               account_management_email: user_params[:account_management_email],
               integration_type: user_params[:integration_type]
              )
      user.save
    end
  end
end
