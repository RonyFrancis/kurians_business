class BillMailer < ApplicationMailer
  def send_bill_mail
    @user = User.find_by(email: params[:email])
    @bill = @user.bills.last
    attachments['bill_image.jpg'] = File.read(@bill.avatar.current_path)
    mail(to: @user.email, subject: 'Your Bill')
  end

  def send_bill_to_admin_mail
    @user = User.find_by(email: params[:email])
    @bill = @user.bills.last
    @admin = User.find_by(is_admin: true)
    attachments['bill_image.jpg'] = File.read(@bill.avatar.current_path)
    mail(to: @admin.email, subject: "#{@user.email}'s Bill")
  end
end
