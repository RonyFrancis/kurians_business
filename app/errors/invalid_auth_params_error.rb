class InvalidAuthParamsError < APIException
  def initialize
    @message = 'Invalid Auth Params'
    @code = '003'
  end
end
