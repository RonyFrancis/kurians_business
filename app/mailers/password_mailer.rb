class PasswordMailer < ApplicationMailer
  default from: 'support@businessbooks.com'
  def send_recover_email
    @user = User.find_by(email: params[:email])
    mail(to: @user.email, subject: 'Temporary Password Created')
  end
end
