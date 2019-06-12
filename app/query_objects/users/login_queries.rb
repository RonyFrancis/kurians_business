module Users
  # LoginQueries
  class LoginQueries
    attr_reader :email, :password
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      raise InvalidLoginError unless valid_params?
      raise IncorrectCredentialsError if valid_user.blank?

      valid_user
    end

    private

    def valid_params?
      (email && password).present?
    end

    def valid_user
      @valid_user ||= User.find_by(email: email, password: Base64.encode64(password))
    end
  end


end
