module Bills
  class CreateQuery
    attr_reader :current_user, :bill_params
    def initialize(current_user:, bill_params:)
      @current_user = current_user
      @bill_params = bill_params
    end

    def call
      raise InvalidParamsError unless valid_params?
      raise InvalidBillParamsError unless bill_params[:image].present?
      raise BillCreationFailureError unless create_bill

      true
    end

    private

    def valid_params?
      (current_user && bill_params).present?
    end

    def create_bill
      bill = Bill.new(
        user_id: current_user.id,
        avatar: bill_params[:bill_image]
      )
      bill.save
    end
  end
end
