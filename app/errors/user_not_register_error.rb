# module Users
  class UserNotRegisterError < APIException
    def initialize
      @message = 'User Not Registered'
      @code = '002'
    end
  end
# end
