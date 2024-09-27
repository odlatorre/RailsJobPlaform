class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(
      to: 'admin@example.com',
      subject: 'Notification new Job Apply'
    )
  end
end

