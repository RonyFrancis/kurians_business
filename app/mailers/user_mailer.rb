class UserMailer < ApplicationMailer
  def send_registration
    @user = User.find_by(email: params[:email])
    attachments['logo.png'] = File.read(app_logo)
    attachments['apple.png'] = File.read(apple_logo)
    attachments['play_store.png'] = File.read(play_store_logo)
    mail(to: @user.email, subject: 'Welcome to business Books')
  end
end
