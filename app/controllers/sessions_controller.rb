class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    # if the user doesn't exist then you need to render new
    # find the user by the email address
    @user = User.find_by(email: params[:user][:email])
    # check if password is correct
    if !@user.nil? && @user.authenticate(params[:user][:password])
      # if password is correct
      # set session
      session[:user_id] = @user.id
      # redirect to user homepage
      redirect_to user_path(@user)
    else
      redirect_to new_session_path, notice: "Error: Invalid email address or password"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Successfully logged out"
  end

end
