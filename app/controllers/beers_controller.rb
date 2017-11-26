class BeersController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @categories = Category.all
    @breweries = Brewery.all
    if !params[:category].blank?
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
