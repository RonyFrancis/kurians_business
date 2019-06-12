class InvalidParamsError < APIException
  def initialize
    @message = 'Invalid Params'
    @code = '005'
  end
end
