class InvalidUserParamsError < APIException
  def initialize
    @message = 'Invalid User Params'
    @code = '007'
  end
end
