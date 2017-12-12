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
    @userbeer = Beer.find_by(id: params[:id])
    # ideally don't want this only accessible via My Beers
    # want to show the status and notes for a beer all the time, not just via special link
    if params[:user_id]
      @status = current_user.user_beers.find_by(id: @userbeer).status
      @notes = current_user.user_beers.find_by(id: @userbeer).notes
    end
  end

  def new
  end

  def create
  end
end
