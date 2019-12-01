module Users
  # LoginQueries
  class LoginQueries
    attr_reader :email, :password, :platform
    def initialize(email:, password: , platform:)
      @email = email
      @password = password
      @platform = platform
    end

    def call
      raise InvalidLoginError unless valid_params?
      raise IncorrectCredentialsError if valid_user.blank?
      raise NotAdminUserError unless admin_check?

      valid_user
    end

    private

    def valid_params?
      (email && password).present?
    end

    def web_platform?
      platform == "web"
    end

    def admin_check?
      return valid_user.is_admin if  web_platform?

      true
    end

    def valid_user
      @valid_user ||= User.find_by(email: email, password: Base64.encode64(password))
    end
  end


end
