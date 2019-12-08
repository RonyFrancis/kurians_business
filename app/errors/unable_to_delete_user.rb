# frozen_string_literal: true

class UnableToDeleteUser < APIException
  def initialize
    @message = 'Can not delete current user'
    @code = '015'
  end
end
