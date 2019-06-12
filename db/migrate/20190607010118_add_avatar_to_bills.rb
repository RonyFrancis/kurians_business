class AddAvatarToBills < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :avatar, :string
  end
end
