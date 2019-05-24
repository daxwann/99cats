class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def welcome_email(user)
    @user = user
    @url = cats_url
    mail(to: "user@example.com", subject: "Welcome to 99Cats")
  end
end
