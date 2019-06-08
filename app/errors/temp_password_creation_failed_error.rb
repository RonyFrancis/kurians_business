class TempPasswordCreationFailedError < APIException
  def initialize
    @message = 'Temp password creation failed'
    @code = '010'
  end
end
