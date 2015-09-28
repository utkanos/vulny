class UserMailer < ActionMailer::Base
  default from: "admin@vulny.xyz"
 
  def welcome_email(user)
    @user = user
    @url  = 'http://vulny.xyz/register/blah'
    mail(to: @user.email, subject: 'Welcome to the Employee Access Portal!')
  end
end
