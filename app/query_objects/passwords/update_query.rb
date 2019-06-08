# frozen_string_literal: true

module Passwords
  # UpdateQuery
  class UpdateQuery
    attr_reader :old_password, :user_name, :new_password
    def initialize(old_password:, user_name:, new_password:)
      @old_password = old_password
      @user_name = user_name
      @new_password = new_password
    end

    def call
      raise InvalidParamsError unless valid_params?
      raise InvalidTempPasswordError unless user.present?
      raise PasswordUpdateFailedError unless update_password

      true
    end

    private

    def valid_params?
      (old_password && user_name && new_password).present?
    end

    def user
      @user ||= User.find_by(
        email: user_name, password: encoded_password(old_password)
      )
    end

    def update_password
      user.update(password: encoded_password(new_password))
    end

    def encoded_password(password)
      Base64.encode64(password)
    end
  end
end
