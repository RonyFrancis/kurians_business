# Example rake file structure
# Define a namespace for the task
namespace :admin do
  # Give a description for the task
  desc "create admin user"
  # Define the task
  task create: :environment do
    user = User.create(
      first_name: 'rony', last_name: 'francis',
      email: 'ronydfrnd@gmail.com', forward_email: 'rony@remitap.com',
      mobile_number: '9061415632', password: Base64.encode64('123456'),
      is_admin: true
    )
    puts "User created " + user.inspect
  end
end
