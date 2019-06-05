class NoUserError < APIException
  def initialize
    @message = 'user Credentials'
    @code = '003'
  end
end
