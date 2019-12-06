module Users
  class FetchUsersByIDS
    attr_reader :ids
    def initialize(ids: ids)
      @ids = ids
    end

    def call
      raise InvalidParamsError unless valid_params?
      raise UserNotFoundError if fetch_users.blank?

      fetch_users
    end

    private

    def valid_params?
      ids.present?
    end

    def fetch_users
      users ||= User.where("id in (?)", ids)
    end
  end
end
