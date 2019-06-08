class UserNotFoundError < APIException
  def initialize
    @message = 'User not found'
    @code = '009'
  end
end
