class User < ApplicationRecord
  validates :email, uniqueness: true

  has_many :bills
  self.per_page = 15
end
