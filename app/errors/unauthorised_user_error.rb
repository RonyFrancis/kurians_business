class UnauthorisedUserError < APIException
  def initialize
    @message = 'Unauthorised User'
    @code = '004'
  end
end
