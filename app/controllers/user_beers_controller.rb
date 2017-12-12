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
  end

  def new
  end

  def create
  end
end
