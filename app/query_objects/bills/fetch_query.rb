# frozen_string_literal: true

module Bills
  # FetchQuery
  class FetchQuery
    attr_reader :user, :page, :url
    def initialize(user:, page:, url:)
      @user = user
      @page = page
      @url = url
    end

    def call
      raise InvalidParamsError unless valid_params?

      bills = Bill.where(user_id: user.id).paginate(
        page: page
      ).order('created_at DESC')
      [fetch_bill_details(bills), pagination_details(bills)]
    end

    private

    def valid_params?
      (user && page && url).present?
    end

    def fetch_bill_details(bills)
      bills.map do |bill|
        {
          id: bill.id,
          name: bill.avatar.file.filename,
          url: url + bill.avatar.url
        }
      end
    end

    def pagination_details(bills)
      {
        current_page: bills.current_page,
        total_pages: bills.total_pages
      }
    end
  end
end
