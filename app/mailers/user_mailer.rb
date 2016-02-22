class UserMailer < ApplicationMailer
  default from: 'no-reply@sloboda-edu.com'

  def notification_email(user, event)
    template(user, event, 'Sloboda EDU reminder: 3 hours left')
  end

  def instant_email(user, event)
    template(user, event,
             "Sloboda EDU reminder: #{event.subject} is about to begin!")
  end

  def info_email(user, event)
    template(user, event,
             "Sloboda EDU reminder: #{event.subject} is rescheduled")
  end

  private

  def template(user, event, subject)
    @user = user
    @event = event
    mail(to: @user.email,
         subject: subject)
  end
end
