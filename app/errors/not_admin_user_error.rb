class NotAdminUserError < APIException
  def initialize
    @message = 'Not Admin user'
    @code = '006'
  end
end
