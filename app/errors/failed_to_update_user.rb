# frozen_string_literal: true

class FailedToUpdateUser < APIException
  def initialize
    @message = 'Failed to update user'
    @code = '014'
  end
end
