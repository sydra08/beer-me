class SessionsController < ApplicationController

  def new
  end

  def create
    # find the user by the email address
    @user = User.find_by(email: params[:user][:email])
    # check if password is correct
    if @user.authenticate(params[:user][:password])
      # if password is correct
      # set session
      session[:user_id] = @user.id
      # redirect to user homepage
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def destroy
  end

end
