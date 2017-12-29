class UserBeersController < ApplicationController
  def index
    @categories = Category.all
    @breweries = Brewery.all
    # filters return beer objects not userbeer ones
    if params[:user_id]
      # set category and brewery
      if !params[:category].blank? && !params[:brewery].blank?
        @userbeers = UserBeer.by_user_and_brewery_and_category(params[:user_id], params[:brewery], params[:category])
        # set just category
      elsif !params[:category].blank?
        @userbeers = UserBeer.by_user_and_category(params[:user_id], params[:category])
        # set just brewery
      elsif !params[:brewery].blank?
        @userbeers = UserBeer.by_user_and_brewery(params[:user_id], params[:brewery])
      else
        # find a beer that user already has in their collection
        @userbeers = UserBeer.by_user(params[:user_id])
      end
    end
  end

  def show
    @userbeer = UserBeer.find_by(id: params[:id])
    # want to show the status and notes for a beer all the time, not just via special link
    # via beers#show if current_user.beers.includes(@beer) then show extra? user needs to be able to see all the info at all times, regardless how they view it
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    binding.pry
    # will need to update this when you are allowed to toggle the beer status on the show page
    @userbeer = UserBeer.find_by(id: params[:id])
    if params[:user_beer][:notes] != ""
      @userbeer.update(user_beer_params)
      redirect_to user_user_beer_path(current_user, @userbeer)
    elsif params[:user_beer][:status] != ""
      @userbeer.update(user_beer_params)
      redirect_to user_user_beer_path(current_user, @userbeer)
    else
      render :show
    end
  end

  private

  def user_beer_params
    params.require(:user_beer).permit(:notes, :status)
  end
end
