# frozen_string_literal: true

module Passwords
  # TempPasswordQuery
  class TempPasswordQuery
    attr_reader :email
    def initialize(email:)
      @email = email
    end

    def call
      raise InvalidParamsError unless email.present?
      raise UserNotFoundError unless user.present?
      raise TempPasswordCreationFailedError unless create_temp_password

      true
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end

    def create_temp_password
      user.update(password: Base64.encode64(
        SecureRandom.hex[0..12]
      ))
    end
  end
end
