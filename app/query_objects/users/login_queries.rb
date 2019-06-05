module Users
  # class APIException < StandardError
  #   attr_reader :message
  #   attr_reader :code
  # end
  #
  # class InvalidLoginError < APIException
  #   def initialize
  #     @message = 'Invalid Login Credentials'
  #     @code = '001'
  #   end
  # end

  class LoginQueries
    attr_reader :email, :password
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      raise InvalidLoginError unless valid_params?
      raise UserNotRegisterError if valid_user.blank?

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
