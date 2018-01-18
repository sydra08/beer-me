class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    # if the user doesn't exist then you need to render new
    # find the user by the email address
    if !auth.nil?
      # did the user use OAuth?
      @user = User.find_by(email: auth.info.email)
      if @user && !@user.provider
        # if the user exists and doesnt have a provider then don't allow OAuth
        redirect_to signin_path, notice: "Error: Email address has already been taken."
        # does the user's email address already exist?
        # if they exist w OAuth or don't exist at all
      else
        @user = User.find_or_create_from_auth_hash(auth)
        session[:user_id] = @user.id
        redirect_to user_user_beers_path(@user)
      end
    else
      # if not sign in the normal way
      @user = User.find_by(email: params[:user][:email])
      if !@user.nil? && @user.authenticate(params[:user][:password])
        # if password is correct
        # set session
        session[:user_id] = @user.id
        # redirect to user homepage
        redirect_to user_user_beers_path(@user)
      else
        redirect_to signin_path, notice: "Error: Invalid email address or password"
      end
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
