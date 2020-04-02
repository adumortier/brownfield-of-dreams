class InvitesController < ApplicationController
  def create
    result = Invite.find_email(invite_params[:github_handle])
    if result.key? 'id'
      existing_user_notification(result)
    else
      flash[:user_not_found] = "The Github user you selected doesn't exist."
    end
    redirect_to '/dashboard'
  end

  def new
    @invite = Invite.new
  end

  private

  def existing_user_notification(result)
    if !result['email'].nil?
      InviteNotifierMailer.inform(current_user, result['email']).deliver_now
      flash[:invite_sent] = 'Successfully sent invite!'
    else
      flash[:email_not_found] = "The Github user you selected doesn't have an email address associated with their account."
    end
  end

  def invite_params
    params.require(:invite).permit(:github_handle)
  end
end
