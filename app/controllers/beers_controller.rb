class BeersController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    flash[:alert] = "NEED TO REFACTOR PAGE"
    # set for filters
    @categories = Category.all
    @breweries = Brewery.all
    # this is for the nested route
    # do we need to create a userbeer?
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

  def show
    @beer = Beer.find_by(id: params[:id])
  end

  def new
    @beer = Beer.new
    @beer.build_brewery
    @beer.build_category
  end

  def create
    binding.pry
    @beer = Beer.find_or_create_by(name: params[:beer][:name])
    # need to assign the creator_ids here as well
    # when you create a beer you are always assigning it to the user
    # need to work on adding beer notes and/or status
    if @beer.update(beer_params)
      current_user.beers << @beer
      redirect_to user_beers_path(current_user)
    else
      render :new
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :abv, :description, brewery_attributes: [:name, :location], category_attributes: [:name])
  end
end
