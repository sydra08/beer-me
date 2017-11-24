class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def require_login
    unless logged_in?
      redirect_to root_path, error: "You must be logged in to do that"
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
