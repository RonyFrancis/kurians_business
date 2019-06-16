class BillMailer < ApplicationMailer
  def send_bill_mail
    @user = User.find_by(email: params[:email])
    @bill = @user.bills.last
    attachments['logo.png'] = File.read(app_logo)
    attachments['bill_image.jpg'] = File.read(@bill.avatar.current_path)
    attachments['apple.png'] = File.read(apple_logo)
    attachments['play_store.png'] = File.read(play_store_logo)
    mail(to: @user.email, subject: 'Your Bill')
  end

  def send_bill_to_admin_mail
    @user = User.find_by(email: params[:email])
    @bill = @user.bills.last
    @admin = User.find_by(is_admin: true)
    attachments['logo.png'] = File.read(app_logo)
    attachments['bill_image.jpg'] = File.read(@bill.avatar.current_path)
    attachments['apple.png'] = File.read(apple_logo)
    attachments['play_store.png'] = File.read(play_store_logo)
    mail(to: @admin.email, subject: "#{@user.email}'s Bill")
  end
end
