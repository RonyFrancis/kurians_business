# frozen_string_literal: true

module Users
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
        (user_params[:mobile_number] && user_params[:password]).present?
    end

    def register
      user = User.new(email: user_params[:email],
                      forward_email: user_params[:forward_email],
                      mobile_number: user_params[:mobile_number],
                      first_name: user_params[:first_name],
                      last_name: user_params[:last_name],
                      password: Base64.encode64(user_params[:password]))
      user.save
    end
  end
end
