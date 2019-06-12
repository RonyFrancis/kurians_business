
  class APIException < StandardError
    attr_reader :message
    attr_reader :code
end
