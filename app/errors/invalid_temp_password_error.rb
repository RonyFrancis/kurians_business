class InvalidTempPasswordError < APIException
  def initialize
    @message = 'Temp password incorrect'
    @code = '011'
  end
end
