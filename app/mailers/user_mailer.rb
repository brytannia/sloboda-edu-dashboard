class UserMailer < ApplicationMailer
  default from: 'no-reply@sloboda-edu.com'

  def notification_email(user, event)
    @user = user
    @event = event
    mail(to: @user.email,
         subject: 'Sloboda EDU reminder')
  end
end
