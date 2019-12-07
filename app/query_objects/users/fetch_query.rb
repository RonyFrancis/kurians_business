module Users
  class FetchQuery
    attr_reader :page, :search_term
    def initialize(page: page, search_term: search_term)
      @page = page
      @search_term = search_term
    end

    def call
      raise InvalidParamsError unless valid_params?
      if search_term.blank?
      users = User.all.select(
        "id", "first_name", "last_name", "email", "forward_email", "status",
        "mobile_number", "is_admin", "created_at", "updated_at"
      ).paginate(page: page).order('created_at DESC')
    else
      users = User.where(
      "first_name like ? or last_name like ? or email like ? or forward_email like ? or mobile_number like ?",
       "%" + search_term + "%","%" + search_term + "%","%" + search_term + "%","%" + search_term + "%","%" + search_term + "%" ).select(
        "id", "first_name", "last_name", "email", "forward_email", "status",
        "mobile_number", "is_admin", "created_at", "updated_at"
      ).paginate(page: page).order('created_at DESC')
    end
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
