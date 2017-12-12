class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    # if the user doesn't exist then you need to render new
    # find the user by the email address
    # request.env['omniauth.auth']
    # auth['info']['email'] => "sydneycstest@gmail.com"
    # auth['info']['first_name'] => "Sydney"
    # auth['info']['image'] => "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"
    # auth['info']['last_name'] => "Chun"
    # auth['provider'] => "google_oauth2"
    # auth['uid'] => "114605032996416049559"
    if !auth.nil?
      # did the user use OAuth?
      @user = User.find_or_create_from_auth_hash(auth)
      binding.pry
      session[:user_id] = @user.id
      redirect_to user_user_beers_path(@user)
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
    redirect_to root_path, notice: "Successfully logged out"
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
