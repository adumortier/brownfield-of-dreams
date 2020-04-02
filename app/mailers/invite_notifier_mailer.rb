class InviteNotifierMailer < ApplicationMailer
  def inform(user, friend_email)
    @user = user
    mail(to: friend_email, subject: "#{@user} invited you to join BrownField Of Dreams")
  end
end
