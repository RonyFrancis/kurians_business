module Users
  class AuthenticationQuery
    attr_reader :email, :auth_token
    def initialize(email: email, auth_token: auth_token)
      @email = email
      @auth_token = auth_token
    end

    def call
      raise InvalidAuthParamsError unless valid_params?
      raise UnauthorisedUserError if authorised_user.blank?

      authorised_user
    end

    private

    def valid_params?
      (email && auth_token).present?
    end

    def authorised_user
      @authorised_user ||= User.find_by(email: email, auth_token: auth_token)
    end
  end
end
