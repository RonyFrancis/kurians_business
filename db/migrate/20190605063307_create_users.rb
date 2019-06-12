class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :forward_email
      t.string :mobile_number
      t.string :auth_token
      t.string :password
      t.boolean :is_admin
      t.timestamps
    end
  end
end
