class Bill < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  belongs_to :user
  self.per_page = 15
end
