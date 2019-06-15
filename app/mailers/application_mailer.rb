class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  private

  def app_logo
    Rails.root.join('app', 'assets', 'images','businessbooks.png')
  end

  def apple_logo
    Rails.root.join('app', 'assets', 'images','apple_store.png')
  end

  def play_store_logo
    Rails.root.join('app', 'assets', 'images','google_play_store.png')
  end
end
