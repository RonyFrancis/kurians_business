module Bills
  class FetchQuery
    def initialize(user:, pagination_params:)
      @user = user
      @pagination_params = pagination_params
    end

    def call
      raise InvalidParamsError unless valid_params?
      raise InvalidPaginationError unless valid_pagination_params?
      
      user.bills
    end

    private
   
    def vaild_params?
      (user && pagination_params).present?
    end

    def valid_pagination_params?
      (pagination_params[:page] && pagination_params[:status]).present?
    end
  end
end
