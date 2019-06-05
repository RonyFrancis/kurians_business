# module Users
class InvalidLoginError < APIException
  def initialize
    @message = 'Invalid Login Credentials'
    @code = '001'
  end
end
# end
