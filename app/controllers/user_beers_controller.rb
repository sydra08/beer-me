class UserBeersController < ApplicationController
  def index
    @categories = Category.all
    @breweries = Brewery.all

    if params[:user_id]
      # set category and brewery
      if !params[:category].blank? && !params[:brewery].blank?
        @userbeers = Beer.by_user_and_brewery_and_category(params[:user_id], params[:brewery], params[:category])
        # set just category
      elsif !params[:category].blank?
        @userbeers = Beer.by_user_and_category(params[:user_id], params[:category])
        # set just brewery
      elsif !params[:brewery].blank?
        @userbeers = Beer.by_user_and_brewery(params[:user_id], params[:brewery])
      else
        # find a beer that user already has in their collection
        @userbeers = User.find_by(id: params[:user_id]).beers
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
    raise params.inspect
  end
end
