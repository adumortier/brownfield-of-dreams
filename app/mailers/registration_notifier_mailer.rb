class RegistrationNotifierMailer < ApplicationMailer

  def register(user)
    @user = user
    mail(to: user.email, subject: "Active your Brownfield of Dreams account")
  end
end
