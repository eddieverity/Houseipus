class MessageMailer < ActionMailer::Base
  default from: 'housipus@gmail.com'
  layout 'mailer'
  def message_email(user)
    @user = user
    @url  = 'http://housipus.com'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
