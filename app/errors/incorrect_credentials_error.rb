# frozen_string_literal: true

class IncorrectCredentialsError < APIException
  def initialize
    @message = 'Incorrect Credentials'
    @code = '002'
  end
end
