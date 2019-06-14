class PasswordMailer < ApplicationMailer
  default from: 'support@businessbooks.com'
  def send_recover_email
    @user = User.find_by(email: params[:email])
    attachments['logo.png'] = File.read(Rails.root.join('app', 'assets', 'images','businessbooks.png'))
    mail(to: @user.email, subject: 'Temporary Password Created')
  end
end
