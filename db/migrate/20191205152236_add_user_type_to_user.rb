class AddUserTypeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_type, :string
    add_column :users, :address, :text
    add_column :users, :tfn, :string
    add_column :users, :dob, :datetime
  end
end
