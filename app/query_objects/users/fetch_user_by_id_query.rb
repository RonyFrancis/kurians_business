module Users
  class FetchUserByIdQuery
    attr_reader :id
    def initialize(id: id)
      @id = id
    end

    def call
      raise InvalidParamsError unless valid_params?
      raise UserNotFoundError if fetch_user.blank?

      fetch_user
    end

    private

    def valid_params?
      id.present?
    end

    def fetch_user
      user ||= User.find_by(id: id)
    end
  end
end
