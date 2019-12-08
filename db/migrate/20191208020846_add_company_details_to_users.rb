class AddCompanyDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :client_type, :string
    add_column :users, :company_name, :string
    add_column :users, :trading_name, :string
    add_column :users, :abn_can, :string
    add_column :users, :company_tfn, :string
    add_column :users, :business_address, :string
    add_column :users, :business_phone_no, :string
    add_column :users, :business_email, :string
    add_column :users, :website, :string
    add_column :users, :industry, :string
    add_column :users, :nominated_contact_person, :string
    add_column :users, :nominated_contact_position, :string
    add_column :users, :account_management_email, :string
  end
end
