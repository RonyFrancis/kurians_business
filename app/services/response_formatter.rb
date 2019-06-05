class ResponseFormatter
  attr_reader :code, :message, :data, :version
  def initialize(code: 200, message: 'success', data: {}, version: 1)
    @code = code
    @message = message
    @data = data
    @version = version
  end

  def call
    {
      code: code,
      message: message,
      data: data,
      version: version
    }
  end
end
