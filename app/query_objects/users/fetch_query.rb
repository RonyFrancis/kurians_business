module Users
  class FetchQuery
    attr_reader :page
    def initialize(page: page)
      @page = page
    end

    def call
      raise InvalidParamsError unless valid_params?

      users = User.all.select(
        "id", "first_name", "last_name", "email", "forward_email",
        "mobile_number", "is_admin", "created_at", "updated_at"
      ).paginate(page: page).order('created_at DESC')
      [users, pagination_details(users)]
    end

    private

    def valid_params?
      (page).present?
    end

    def pagination_details(users)
      {
        current_page: users.current_page,
        total_pages: users.total_pages
      }
    end
  end
end
