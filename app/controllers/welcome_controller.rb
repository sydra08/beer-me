class WelcomeController < ApplicationController
  def home
    render :layout => 'home_page'
  end
end
