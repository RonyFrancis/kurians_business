class PasswordMailer < ApplicationMailer
  default from: 'support@businessbooks.com'
  def send_recover_email
    @user = User.find_by(email: params[:email])
    attachments['logo.png'] = File.read(app_logo)
    attachments['apple.png'] = File.read(apple_logo)
    attachments['play_store.png'] = File.read(play_store_logo)
    mail(to: @user.email, subject: 'Temporary Password Created')
  end
end
