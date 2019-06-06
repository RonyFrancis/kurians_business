class DuplicateUserError < APIException
  def initialize
    @message = 'Duplicate User'
    @code = '008'
  end
end
