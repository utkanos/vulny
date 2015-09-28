class UserMailer < ActionMailer::Base
  default from: "admin@vulny.xyz"
 
  def welcome_email(email)
    @url  = 'http://vulny.xyz/confirm?token=YDTtggc5effrfXFE&email='+email
    mail(to: email, subject: 'Welcome to the Employee Access Portal!')
  end
end
