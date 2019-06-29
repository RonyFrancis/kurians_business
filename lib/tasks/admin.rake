# Example rake file structure
# Define a namespace for the task
namespace :admin do
  # Give a description for the task
  desc "create admin user"
  # Define the task
  task create: :environment do
    user = User.create(
      first_name: 'Sahil', last_name: 'Kansal',
      email: 'info@businessbooks.com.au', forward_email: 'info@businessbooks.com.au',
      mobile_number: '0450300655', password: Base64.encode64('Abin2019'),
      is_admin: true
    )
    puts "User created " + user.inspect
  end
end
