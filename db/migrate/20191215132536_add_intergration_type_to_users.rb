class AddIntergrationTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :integration_type, :string
  end
end
