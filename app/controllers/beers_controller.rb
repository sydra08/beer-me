class BeersController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    # set for filters
    @categories = Category.all
    @breweries = Brewery.all
    # this is for the nested route
    if params[:user_id]
      if !params[:category].blank? && !params[:brewery].blank?
        @beers = Beer.by_user_and_brewery_and_category(params[:user_id], params[:brewery], params[:category])
      elsif !params[:category].blank?
        @beers = Beer.by_user_and_category(params[:user_id], params[:category])
      elsif !params[:brewery].blank?
        @beers = Beer.by_user_and_brewery(params[:user_id], params[:brewery])
      else
        @beers = User.find_by(id: params[:user_id]).beers
      end
    else
      # for regular index page
      if !params[:category].blank? && !params[:brewery].blank?
        binding.pry
        @beers = Beer.by_category_and_brewery(params[:category], params[:brewery])
      elsif !params[:category].blank?
        @beers = Beer.by_category(params[:category])
      elsif !params[:brewery].blank?
        @beers = Beer.by_brewery(params[:brewery])
      else
        @beers = Beer.all
      end
    end
  end

  def show
    @beer = Beer.find_by(id: params[:id])
    # ideally don't want this only accessible via My Beers
    # want to show the status and notes for a beer all the time, not just via special link
    if params[:user_id]
      @status = current_user.user_beers.find_by(id: @beer).status
      @notes = current_user.user_beers.find_by(id: @beer).notes
    end
  end

  def new
    @beer = Beer.new
    @beer.build_brewery
    @beer.build_category
  end

  def create
    @beer = Beer.find_or_create_by(name: params[:beer][:name])
    # need to assign the creator_ids here as well
    if @beer.update(beer_params)
      binding.pry
      current_user.beers << @beer
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, brewery_attributes: [:name, :location], category_attributes: [:name])
  end
end
