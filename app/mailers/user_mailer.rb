class UserMailer < ApplicationMailer
  default from: 'eddieverity@gmail.com'

  def message_email(user)
    @user = user
    mail(to: @user.email, subject: 'Message from Houseipus!')
  end
end
