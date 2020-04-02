class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      flash[:logged_in] = "Logged in as #{user_params[:first_name]} #{user_params[:last_name]}"
      flash[:check_emails] = 'This account has not yet been activated. Please check your email.'
      session[:user_id] = user.id
      RegistrationNotifierMailer.register(user).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:token])
    if user
      user.activate
      flash[:success] = 'Welcome to the Brownfield of Dreams! Your account is activated.'
      redirect_to '/dashboard'
    else
      flash[:error] = 'Sorry. User does not exist'
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
