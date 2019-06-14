class InvalidPaginationParamsError < APIException
  def initialize
    @message = 'Invalid Pagination Params'
    @code = '011'
  end
end
